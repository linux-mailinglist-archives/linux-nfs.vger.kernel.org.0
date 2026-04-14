Return-Path: <linux-nfs+bounces-20836-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4HPeIrFo3mmxDgAAu9opvQ
	(envelope-from <linux-nfs+bounces-20836-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Apr 2026 18:17:53 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E073FC723
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Apr 2026 18:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 06DC530A925F
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Apr 2026 16:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3434E3ECBD9;
	Tue, 14 Apr 2026 16:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mW1bCGfk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AA43E63AD
	for <linux-nfs@vger.kernel.org>; Tue, 14 Apr 2026 16:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776183143; cv=pass; b=Ru4iAG4gz3f85jMUmJNPIodvKeCm2JLOxwxWc4KWj0g2tHxaVKYnQcmZpVnpsov7bSHgXQmYaRBSnoUTvw2S6DcabRfZSUN0z3zj5PBtKxA9XcdCMmqLRaQOcHBmwQk1a1TGBbvZI6AGyyzMN9mpn0CsInfteTl20xon3gkB2+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776183143; c=relaxed/simple;
	bh=vrADkzCmSu5NSGmrsPeOtbNW0Bal+/wN2xy8P+gFdjA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H1id3RgppGxnZLEzAzvGUNeHuOci97xbN848dpwcUOIxR5KtoM761z1YFggLDtXbV0bCYRnkjug7aQG7F1abQga0CdYnxSalDj71VZ5+Ftm0XuinKjfpvbhrqi688SKjjDNXftHsLDuT1CW1kYbqUAEn9jShckcMc5HzVNzz4RA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mW1bCGfk; arc=pass smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-6108228a851so673055137.0
        for <linux-nfs@vger.kernel.org>; Tue, 14 Apr 2026 09:12:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776183141; cv=none;
        d=google.com; s=arc-20240605;
        b=Zx9YWShslnmixkpozCe7S0IJHSAYoVRJIAEtTt0trbAYbQZn2RBGJvIg13leAYUjvS
         mmdGjbzyWVoyBHObcZBzzsQyRszR06EV6CtY1AWABvaAG0RhSO6jyfGUQ7zaBBwBoodB
         VOUpTI3qWl9mUi4nKaTRo5y4UK5V8Fey8qKqJJFxuOoa03T338t83n9g9wU83niXx2rc
         0zUf20E6cTzpc7LtELH2wphtbjZRujwudtQ1QyuHy2e4ibQgzwAM//wqV+LpIDbqw018
         P8YMNLv9F63qz4sD27e4fjgFXNPBQgEEpGhlgDYUZOUmowJeAsPQt4MFG+urjTCXuTcw
         JUnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=N1adwSRbKvfHO0bXwsoRQNtVNaWupXhhwwq7ww9Pgu8=;
        fh=NyxsFA5DGwgmcrFX7UYI62p8GC416FwzSww+1OpbLTc=;
        b=K0eHCtCyjpX1f6Ncg2rQb+vl5OcwfWd7Z0zcl9Sgfb/h5CRmQp+SVmH9m/JCh5MbuY
         XjfLvODPhFMACYpX2EcOY2WbACZb72ZRTi/UiWxmMp4Z5InHXrP7M8fKyFPExmx10xLr
         eY5/XDqJxVvl1VzwT6CGBffD/D+nc+iv5WBdMnAQZn6eqiFqr8ATZUE5YZNtHmWDE05O
         Y2+b0qIT+RXqH+DI11hPmaLqO6LqHqwxkOE/VPqGeGcxqc+HpbH04DqhmkYn5LrDaUiu
         bUFBZbD5hh5mdCzYtEEBnOAbuA4z+2ivEehGrESoAneaEfSoE88wWYQoZSFfZO8CuFEY
         5n8Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776183141; x=1776787941; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N1adwSRbKvfHO0bXwsoRQNtVNaWupXhhwwq7ww9Pgu8=;
        b=mW1bCGfk6plL92a+v9vVkSAwlSlUUfdoR6agBZvCGb51QObeNugPYO1L8WKxeBv4yk
         UaiWEMJxA4mRQtuUe88DA/Hjn48oiCuSgDXUGCUVjGXkY0gxG3Ij1yHVcch76Mq5to4T
         81KIuxNNMf72Hy/0RjOgA/5LKluGWHJ/S7EwqyelDHRRHguSp1dVSTE0TluIcwHJOiOH
         mPkPG1qToeOlNxwzJzfKPvYT7B2hBPQDQt7KTNHFsd8/zduOCaJ+gC1wTBY9t2Uy3uRn
         3VfnOITxUMLLH+ymfgZeP4FpaIVPteSrvvsWoChPinqzfo2QUOzR3xxwopP5CklGM+Fh
         WbNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776183141; x=1776787941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N1adwSRbKvfHO0bXwsoRQNtVNaWupXhhwwq7ww9Pgu8=;
        b=IMECQ/zhetSGbPPuk7vB4/OqApuZy5GPcr/Pkc9uT1hmiFHbywXnPfUmtR1XxqeWcw
         68zsxzZte5VeQiJwokaXzhngfk0ihuVWo8VVi+hyraS14K/zGN+Myn3zU9IVflu1UBVk
         n2ASch7yXpDkV3syVSMsqB209BGEod2YDaW1/y7LgtAFW96RSt2BFxNgahyDEzrNK49v
         LP9ONJvurGXJXBj5uxvnBfr+IQu2QeLRiONs6RBpiSccd5lchiwSQFEcfZW2yGPzNwf7
         fBJHQzgAHhLNIGIYdqEYEDyxigviJpqCyYtdXrW0iIKPbgMRSLAOW3DQmSasLbA+g4Jv
         yagg==
X-Forwarded-Encrypted: i=1; AFNElJ9ikWoaby8ZAd8TGg7wf+Z2MAQZr9tyU2d1xmIiZm2g3I/Uaq1+fTWCxcIkCDdZonpyf9YuYj/zdW4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLWhPyzkMVAPE1AUcNAPRdml0Z5yOyWEM63/t9/UIrLz4PXCJe
	wHvJ+3kXlMn5qi1JvY2UlhdPt3+5VV6VATs/9WqUGa8pYqA/aWdpTb9iGkwOgxzPc/GvtwOQx2l
	isOGwCBrK7zY+lQpMhe+tenECytKirPk=
X-Gm-Gg: AeBDieuoEMBFwrkQG9uOVwEkqjuVFwtqkXjzJrDJoGG321Vi1xeqeegJsGxouVj6o6Y
	gx99PgRXTjBreVrbWHmYy8WU/RfJHqEBu/uQoEUwdQrOWpqucDO4tmTBOxH0tWMrj5KEG/+lm5f
	RK5fKtN8zlWr/EljCFTQRnNjTISse70sGpoEbj1izlL04ns/0fTmsW0dWcPrpE42hGtbQrj9ic6
	6MWBfaytVjutewLf5LJjyvU3NLNSEPwXbW4h61AVq8ZrAbYjn/ZwRfqkcQGWctLI4ydfTYXnx36
	sJFc+s4=
X-Received: by 2002:a05:6102:83d9:b0:605:5ff6:8104 with SMTP id
 ada2fe7eead31-609fb55f774mr6668013137.0.1776183139602; Tue, 14 Apr 2026
 09:12:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408161428.155169-1-seanwascoding@gmail.com>
 <20260408161428.155169-2-seanwascoding@gmail.com> <C9851FD8-FFFA-47DD-BAA7-F465F293295B@hammerspace.com>
In-Reply-To: <C9851FD8-FFFA-47DD-BAA7-F465F293295B@hammerspace.com>
From: Sean Chang <seanwascoding@gmail.com>
Date: Wed, 15 Apr 2026 00:12:07 +0800
X-Gm-Features: AQROBzCcHcE0XaKRy5WJ9YDhCJ9cOgcEpIyOE9fP474Dh85aDiB6dY3lIyrjAb0
Message-ID: <CAAb=EJUfoq0dq=mSciyoBjTGWM05QKAHgRUZebq0pDh82pQ0gw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] NFS: fix RCU safety in nfs_compare_super_address
To: Benjamin Coddington <ben.coddington@hammerspace.com>
Cc: trondmy@kernel.org, anna@kernel.org, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20836-lists,linux-nfs=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanwascoding@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hammerspace.com:email]
X-Rspamd-Queue-Id: 03E073FC723
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 10, 2026 at 11:09=E2=80=AFPM Benjamin Coddington
<ben.coddington@hammerspace.com> wrote:
>
> On 8 Apr 2026, at 12:14, Sean Chang wrote:
>
> > The cl_xprt pointer in struct rpc_clnt is marked as __rcu. Accessing
> > it directly in nfs_compare_super_address() without RCU protection is
> > unsafe and triggers Sparse warnings about dereferencing noderef
> > expressions.
> >
> > Fix this by wrapping the access with rcu_read_lock() and using
> > rcu_dereference() to safely retrieve the transport pointer. This
> > ensures the xprt remains valid during the comparison of network
> > namespaces and addresses, preventing potential use-after-free during
> > concurrent transport updates.
> >
> > Signed-off-by: Sean Chang <seanwascoding@gmail.com>
>
> Fixes: 7e3fcf61abde ("nfs: don't share mounts between network namespaces"=
)
>
> > ---
> >  fs/nfs/super.c | 32 ++++++++++++++++++++++----------
> >  1 file changed, 22 insertions(+), 10 deletions(-)
> >
> > diff --git a/fs/nfs/super.c b/fs/nfs/super.c
> > index 7a318581f85b..071337f9ea37 100644
> > --- a/fs/nfs/super.c
> > +++ b/fs/nfs/super.c
> > @@ -1166,43 +1166,55 @@ static int nfs_set_super(struct super_block *s,=
 struct fs_context *fc)
> >  static int nfs_compare_super_address(struct nfs_server *server1,
> >                                    struct nfs_server *server2)
> >  {
> > +     struct rpc_xprt *xprt1, *xprt2;
> >       struct sockaddr *sap1, *sap2;
> > -     struct rpc_xprt *xprt1 =3D server1->client->cl_xprt;
> > -     struct rpc_xprt *xprt2 =3D server2->client->cl_xprt;
> > +     int ret =3D 0;
> > +
> > +     rcu_read_lock();
> > +
> > +     xprt1 =3D rcu_dereference(server1->client->cl_xprt);
> > +     xprt2 =3D rcu_dereference(server2->client->cl_xprt);
> > +
> > +     if (!xprt1 || !xprt2)
> > +             goto out;
>
> ^^ I'm not sure that's a great test, the rpc_xprt objects are refcounted.
> These might not be null but you could still race with a freeing path?
>
> However, I think you might just be safe inside the RCU section here becau=
se
> rpc_switch_client_transport() uses synchronize_rcu() before xprt_put(old)=
.
> I didn't audit all the freeing paths.
>

Thanks for the insightful feedback and for auditing the
rpc_switch_client_transport path!

You're absolutely right that synchronize_rcu() provides
a safety net during transport switches. However, to ensure
robustness across all potential freeing paths (including
those not yet fully audited) and to address the race you
mentioned, I've updated the patch to check the xprt state:

+        if (!xprt1 || !xprt2 ||
+            !test_bit(XPRT_CONNECTED, &xprt1->state) ||
+            !test_bit(XPRT_CONNECTED, &xprt2->state))
+                goto out_unlock;

The XPRT_CONNECTED check ensures that the transport
is not only memory-safe (via RCU) but also logically active.

Since the RPC layer clears this bit before initiating the teardown
of an rpc_xprt, this prevents accessing xprt_net on an object
that is on the freeing path.

> >       if (!net_eq(xprt1->xprt_net, xprt2->xprt_net))
> > -             return 0;
> > +             goto out;
>
> Probably safe to drop the RCU protection scope after this point.  No need=
 to
> hold it over all the other checks..
>

Agreed. The RCU protection is indeed only necessary for fetching
and comparing the network namespaces from the rpc_xprt objects.
I will move rcu_read_unlock() to immediately after the net_eq check
in v2 to keep the critical section as small as possible.
Thanks!

Best Regards,
Sean

