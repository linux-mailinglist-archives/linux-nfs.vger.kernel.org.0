Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6313F4730B5
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Dec 2021 16:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234728AbhLMPlN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 13 Dec 2021 10:41:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51202 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232268AbhLMPlN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 13 Dec 2021 10:41:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639410072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W7DzTVpkIqn64HN9Q3U4e/f5j/0v+uj84vskNyCJC8o=;
        b=AWnygIsF02Gmjqv2RznA9tYu28LaC5gr5RDjU6T8KPbbhp6FZh9GtuLZTBjW3nlOCtBQiY
        3vnOEvt8xbsA9cHUZ7lS0OfDAxU5OY0FZPevqfd+cy414g1CJ+yJUfCGAz6WppIf5TCOdr
        PQTAEIZCnWtjKJpP407WZC+0XId/KrA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-506-9Gh-_YGWMbmIPACHCpfFyw-1; Mon, 13 Dec 2021 10:41:11 -0500
X-MC-Unique: 9Gh-_YGWMbmIPACHCpfFyw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 466B5100CCC1
        for <linux-nfs@vger.kernel.org>; Mon, 13 Dec 2021 15:41:10 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.122])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6F35D5DF4B;
        Mon, 13 Dec 2021 15:41:09 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CALF+zOnmJ0=j8pEMikpxYgLrS10gVZiXfCjBhDz9Je0Qip7wnw@mail.gmail.com>
References: <CALF+zOnmJ0=j8pEMikpxYgLrS10gVZiXfCjBhDz9Je0Qip7wnw@mail.gmail.com> <163906878733.143852.5604115678965006622.stgit@warthog.procyon.org.uk> <CALF+zOnA2U6LjDTE8m2REDTMmFVnWkcBkn0ZJQRGULPUjeQW4Q@mail.gmail.com>
To:     David Wysochanski <dwysocha@redhat.com>
Cc:     dhowells@redhat.com, linux-cachefs <linux-cachefs@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Subject: [PATCH] fscache: Need to go round again after processing LRU_DISCARDING state
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <599330.1639410068.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 13 Dec 2021 15:41:08 +0000
Message-ID: <599331.1639410068@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

David Wysochanski <dwysocha@redhat.com> wrote:

> > [  432.921382] BUG: KASAN: use-after-free in
> > fscache_unhash_cookie+0x9e/0x160 [fscache]^M

I think the patch below is the way to fix this.

David
---
fscache: Need to go round again after processing LRU_DISCARDING state

There's a race between the LRU discard and relinquishment actions.  In the
state machine, fscache_cookie_state_machine(), the ACTIVE state transits t=
o
the LRU_DISCARD state in preference to transiting to the RELINQUISHING or
WITHDRAWING states.

This should be fine, but the LRU_DISCARDING state just breaks out the
bottom of the function without going round again after transiting to the
QUIESCENT state.

However, if both LRU discard and relinquishment happen *before* the SM
runs, one of the queue events will get discarded, along with the ref that
would be associated with it.  The last ref is then discarded and the cooki=
e
is removed without completing the relinquishment process - leaving the
cookie hashed.

The fix is to make sure that the SM always goes back around after changing
the state.

Signed-off-by: David Howells <dhowells@redhat.com>
---

diff --git a/fs/fscache/cookie.c b/fs/fscache/cookie.c
index d7e825d636e2..8d0769a5ee2b 100644
--- a/fs/fscache/cookie.c
+++ b/fs/fscache/cookie.c
@@ -755,7 +755,7 @@ static void fscache_cookie_state_machine(struct fscach=
e_cookie *cookie)
 		set_bit(FSCACHE_COOKIE_NO_DATA_TO_READ, &cookie->flags);
 		__fscache_set_cookie_state(cookie, FSCACHE_COOKIE_STATE_QUIESCENT);
 		wake =3D true;
-		break;
+		goto again_locked;
 =

 	case FSCACHE_COOKIE_STATE_DROPPED:
 		break;

