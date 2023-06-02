Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E516720AF5
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Jun 2023 23:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235360AbjFBV2q (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 2 Jun 2023 17:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234676AbjFBV2p (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 2 Jun 2023 17:28:45 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF54DE4E
        for <linux-nfs@vger.kernel.org>; Fri,  2 Jun 2023 14:28:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C91301FE08;
        Fri,  2 Jun 2023 21:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1685741313; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zz5ziYFUFHP9/yHiDf1wsoEfkN3HDB6deqgE09uOyG4=;
        b=kXYeTkzHs0AZlCNINokphwtYOJytZxf+cK3ZWOwPGKhHGU4RhF61VYrEDob9AFMxEcQp/4
        dczeCYo4zxqziD1kaT0gHkpkEjkx2kJAxeWyzLgnY1sH/9GRCgjEx56S91Vh7+oC5CEM8d
        xxTKwlwksuvyDzzWyDRNZOhGKDYLa3Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1685741313;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zz5ziYFUFHP9/yHiDf1wsoEfkN3HDB6deqgE09uOyG4=;
        b=O3gocleQkFgehLIbqfYNDMeKAD4G46HwWWmrp9uBgphj/oLrcZDhR5KuqrAnCRLobjrGsk
        wPP29xuQ7SuLI+AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3A4D213A2E;
        Fri,  2 Jun 2023 21:28:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9HUNN/9eemR7BAAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 02 Jun 2023 21:28:31 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Ido Schimmel" <idosch@idosch.org>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        "Chuck Lever" <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 13/20] lockd: move lockd_start_svc() call into lockd_create_svc()
In-reply-to: <ZHoO3GRH6h/bcRjm@shredder>
References: <163816133466.32298.13831616524908720974.stgit@noble.brown>,
 <163816148560.32298.15560175172815507979.stgit@noble.brown>,
 <ZHoO3GRH6h/bcRjm@shredder>
Date:   Sat, 03 Jun 2023 07:28:28 +1000
Message-id: <168574130862.10905.10707785007987424080@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, 03 Jun 2023, Ido Schimmel wrote:
> On Mon, Nov 29, 2021 at 03:51:25PM +1100, NeilBrown wrote:
> > lockd_start_svc() only needs to be called once, just after the svc is
> > created.  If the start fails, the svc is discarded too.
> >=20
> > It thus makes sense to call lockd_start_svc() from lockd_create_svc().
> > This allows us to remove the test against nlmsvc_rqst at the start of
> > lockd_start_svc() - it must always be NULL.
> >=20
> > lockd_up() only held an extra reference on the svc until a thread was
> > created - then it dropped it.  The thread - and thus the extra reference
> > - will remain until kthread_stop() is called.
> > Now that the thread is created in lockd_create_svc(), the extra
> > reference can be dropped there.  So the 'serv' variable is no longer
> > needed in lockd_up().
>=20
> Hi,
>=20
> I'm seeing the following memory leak [1] after unmounting a network
> share. High level bisection shows that it started between v5.16 and
> v5.17. Using git bisect [2] I've pinpointed it to this patch.
>=20
> Can you please look into it? I can easily trigger the issue and test
> patches.

Thanks for the report.
Please test this patch.

Thanks,
NeilBrown


From 4f7278cb24a0331c1d58cc502029f8bf06bd4e9d Mon Sep 17 00:00:00 2001
From: NeilBrown <neilb@suse.de>
Date: Sat, 3 Jun 2023 07:14:14 +1000
Subject: [PATCH] lockd: drop inappropriate svc_get() from locked_get()

The below-mentioned patch was intended to simplify refcounting on the
svc_serv used by locked.  The goal was to only ever have a single
reference from the single thread.  To that end we dropped a call to
lockd_start_svc() (except when creating thread) which would take a
reference, and dropped the svc_put(serv) that would drop that reference.

Unfortunately we didn't also remove the svc_get() from
lockd_create_svc() in the case where the svc_serv already existed.
So after the patch:
 - on the first call the svc_serv was allocated and the one reference
   was given to the thread, so there are no extra references
 - on subsequent calls svc_get() was called so there is now an extra
   reference.
This is clearly not consistent.

The inconsistency is also clear in the current code in lockd_get()
takes *two* references, one on nlmsvc_serv and one by incrementing
nlmsvc_users.   This clearly does not match lockd_put().

So: drop that svc_get() from lockd_get() (which used to be in
lockd_create_svc().

Reported-by: Ido Schimmel <idosch@idosch.org>
Fixes: b73a2972041b ("lockd: move lockd_start_svc() call into lockd_create_sv=
c()")
Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/lockd/svc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
index 04ba95b83d16..22d3ff3818f5 100644
--- a/fs/lockd/svc.c
+++ b/fs/lockd/svc.c
@@ -355,7 +355,6 @@ static int lockd_get(void)
 	int error;
=20
 	if (nlmsvc_serv) {
-		svc_get(nlmsvc_serv);
 		nlmsvc_users++;
 		return 0;
 	}
--=20
2.40.1

