Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41DF77A1353
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Sep 2023 03:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbjIOBzJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 14 Sep 2023 21:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbjIOBy7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 14 Sep 2023 21:54:59 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11394C3D;
        Thu, 14 Sep 2023 18:52:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5BF461F74B;
        Fri, 15 Sep 2023 01:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1694742721; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VfSlGTI78LzrwujVTg1Dy+42n81WkfT7MFhFZD+AQD0=;
        b=pS2xFeLYt//6VYt6FylnPEa5GnGp1mDfir1JQJy9HTTsu+Zehw0BbdF5fqzQuxMc6a2Ci7
        R16/zb0GZk1KcxwdG1S4i/+TsUvTIr5+9X7t01i+kioI+zS+Hoviu2G8mysjzDBtmjyeWl
        ni12+CG7FnOk47TF237ETI59azcTFwE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1694742721;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VfSlGTI78LzrwujVTg1Dy+42n81WkfT7MFhFZD+AQD0=;
        b=3cMNy0f/HuRqRw45J11T2+bi0J60kVuWqEMJL8CUF4/BuK2H8xg3//FtfywIaLOozZfqik
        pSQqPGnlRVxBSnCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 42B601358A;
        Fri, 15 Sep 2023 01:51:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id t12gOb24A2XkEQAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 15 Sep 2023 01:51:57 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever III" <chuck.lever@oracle.com>
Cc:     "Chuck Lever" <cel@kernel.org>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
        "Liam Howlett" <liam.howlett@oracle.com>,
        "Kees Cook" <keescook@chromium.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "David Gow" <davidgow@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Andrew Morton" <akpm@linux-foundation.org>
Subject: Re: [PATCH v1 11/17] lib: add light-weight queuing mechanism.
In-reply-to: <DB109932-C918-4F1E-BAF2-92D921238D54@oracle.com>
References: <169444233785.4327.4365499966926096681.stgit@bazille.1015granger.net>,
 <169444318342.4327.18355944158180782708.stgit@bazille.1015granger.net>,
 <20230911111333.4d1a872330e924a00acb905b@linux-foundation.org>,
 <4D5C2693-40E9-467D-9F2F-59D92CBE9D3B@oracle.com>,
 <20230911140439.b273bf9e120881f038da0de7@linux-foundation.org>,
 <169447439989.19905.9386812394578844629@noble.neil.brown.name>,
 <20230911183025.5f808a70a62df79a3a1e349e@linux-foundation.org>,
 <DB109932-C918-4F1E-BAF2-92D921238D54@oracle.com>
Date:   Fri, 15 Sep 2023 11:51:54 +1000
Message-id: <169474271454.8274.2673279792882072455@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 15 Sep 2023, Chuck Lever III wrote:
>=20
> > On Sep 11, 2023, at 9:30 PM, Andrew Morton <akpm@linux-foundation.org> wr=
ote:
> >=20
> > On Tue, 12 Sep 2023 09:19:59 +1000 "NeilBrown" <neilb@suse.de> wrote:
> >=20
> >> Plain old list_heads (which the code currently uses) require a spinlock
> >> to be taken to insert something into the queue.  As this is usually in
> >> bh context, it needs to be a spin_lock_bh().  My understanding is that
> >> the real-time developers don't much like us disabling bh.  It isn't an
> >> enormous win switching from a list_head list to a llist_node list, but
> >> there are small gains such as object size reduction and less locking.  I
> >> particularly wanted an easy-to-use library facility that could be
> >> plugged in to two different uses cases in the sunrpc code and there
> >> didn't seem to be one.  I could have written one using list_head, but
> >> llist seemed a better fix.  I think the code in sunrpc that uses this
> >> lwq looks a lot neater after the conversion.
> >=20
> > Thanks.  Could we please get words such as these into the changelog,
> > describing why it was felt necessary to add more library code?
> >=20
> > And also into the .c file, to help people who are looking at it and
> > wondering "can I use this".  And to help reviewers who are wondering
> > "could they have used Neil's thing".
>=20
> Neil, are you planning to send along a replacement for 11/17,
> or would you like me to fold the above into the patch description
> I have now?

Sorry I didn't reply sooner - been busy.
I'll send a patch that can be squashed in to 11/17 which adds some more
explanatory text.  Hopefully soonish.

NeilBrown
