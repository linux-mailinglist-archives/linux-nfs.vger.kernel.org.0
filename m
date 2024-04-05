Return-Path: <linux-nfs+bounces-2685-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CED989A580
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Apr 2024 22:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 013F91F2324B
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Apr 2024 20:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC4D174EC5;
	Fri,  5 Apr 2024 20:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PunGqEXj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13983172BCE
	for <linux-nfs@vger.kernel.org>; Fri,  5 Apr 2024 20:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712347913; cv=none; b=R7oS1/RkeTdtYhNDWLsfIGEta1BogIfKbhyQdjHjBoCly1PuTTyavNw9YXDgQW/KYJARw2/qbB8NaHd8P1K7SFtouwzTmBTpQW7pR00Nh38cyt5oRK8GmBp646/OAeJF4X23KfWqyrEeZRrQ+fIbxFLwVpzGBQs5J6vhL04I/78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712347913; c=relaxed/simple;
	bh=+WOGzChq2Kxqaxaf0+jxeK0j7+8EmTC2PshNHOBZahY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ov8yyQXTFf8OOgwG8zmSpRj2ZQIb2EPK0n73JqmjjF3ijdPhxWFZH0sYPxCAjbpV+sjmJ3FdSyZJxPDwGCpTDBBQgMJzeEaDn8UiU8137JTu367NIQzGaHrzpSF2VKBX6TQ3wkEgWscP1TzvTJkGet3Srei/0VZOij/loHQZOMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PunGqEXj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712347910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SAgOnBaLMvzVz7iNRcvA3GgHfkxFPcBiz3Kz5lopPUc=;
	b=PunGqEXjBEKv5JUqqIbjl9C/8MnA1VyFgP3250h0T/J45qm6+t5jdHAG4qH7LYkp6BCm1P
	o8GQb3MgvSMZC6XAY+iFmvxgpMS9D3rOxjC2An1aMiksiunw/J1dfOnJm6ndmBXmqJW04Y
	Qs8uHSMgArs4vMcorDm/bXl0+EdAPwg=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-OzAYvLE5O7K9RFz9zpwRIg-1; Fri, 05 Apr 2024 16:11:48 -0400
X-MC-Unique: OzAYvLE5O7K9RFz9zpwRIg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a45acc7f191so167343666b.0
        for <linux-nfs@vger.kernel.org>; Fri, 05 Apr 2024 13:11:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712347907; x=1712952707;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SAgOnBaLMvzVz7iNRcvA3GgHfkxFPcBiz3Kz5lopPUc=;
        b=kZ+Kx/e7PxGhEwQXoDtocPMs0dg+c9q7WBRmws1P68aY8ivkDqvRt59bfkgbf8r2IF
         5/y4s2L6j+QS558R8+/xFR0kgFgL9C2oVipTZv4a6vame9jKI5kuwDYk8XzRo0A6m732
         Ma61HMRaWVCSBeV2loiylLd+30eR11WZzQPprSdOZV76bhesnOwAwzmnH8HSm5Q39cTa
         M0unXRR1ePHx68wdi/P96skYP5qyI823t/XAy3PCfJ0fvBE29UXv1tH3NbLQYxiAY4nb
         A47AifbcGhgqbXZmDlPSOzSMevSAu7Hh/FRlXnv+FwVMbgQKuSGGiOO2o3bzFkf1/iM6
         3lRg==
X-Forwarded-Encrypted: i=1; AJvYcCXSlZDRepn1acQp+VDNh2Ri77XYITqwLG9FxAXlsfi/adIyQLeDEnEXwyUL8Oosele0+ENEXDymAFEsVSj15uW3iLw5UH4pGs0j
X-Gm-Message-State: AOJu0YzEaWKeSWJ52ncXmwpaDjuHOimMkH9214nQLRle8fQ/YPevghVf
	2qJY/PLn+ekg0ZGfBFg/8gCKXg50mwmagu4Fwl4SC/8sVAy1bVh9uXmOLuSbwRA9nmuUQF8G4fG
	MLKfbxxdy+8QXTarsDKkrumS3xIUJUmf/gHJasikGSwe+CrDw21X5LjDAHQ==
X-Received: by 2002:a17:906:3b4d:b0:a4e:24af:d8a4 with SMTP id h13-20020a1709063b4d00b00a4e24afd8a4mr1738766ejf.28.1712347907199;
        Fri, 05 Apr 2024 13:11:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnvO/Os4SHQi+5vTGAC2ejxy/i2mN/3FawVVfJbvGqJnm12XmhZQ2H0tRZQbWRHhCxo/1UBQ==
X-Received: by 2002:a17:906:3b4d:b0:a4e:24af:d8a4 with SMTP id h13-20020a1709063b4d00b00a4e24afd8a4mr1738765ejf.28.1712347906828;
        Fri, 05 Apr 2024 13:11:46 -0700 (PDT)
Received: from [192.168.1.121] (cst2-173-128.cust.vodafone.cz. [31.30.173.128])
        by smtp.gmail.com with ESMTPSA id va12-20020a17090711cc00b00a4eeb5ff4ddsm1179370ejb.152.2024.04.05.13.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 13:11:46 -0700 (PDT)
Message-ID: <2ebbe58df9575136583f65cd19d133bdb61d5c20.camel@redhat.com>
Subject: Re: [PATCH v2] nfsd: hold a lighter-weight client reference over
 CB_RECALL_ANY
From: vbenes@redhat.com
To: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>
Cc: Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>, Dai
 Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 linux-nfs@vger.kernel.org,  linux-kernel@vger.kernel.org
Date: Fri, 05 Apr 2024 22:11:45 +0200
In-Reply-To: <ZhA93BQSxkJqmqaw@tissot.1015granger.net>
References: <20240405-rhel-31513-v2-1-b0f6c10be929@kernel.org>
	 <ZhA93BQSxkJqmqaw@tissot.1015granger.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-04-05 at 14:07 -0400, Chuck Lever wrote:
> On Fri, Apr 05, 2024 at 01:56:18PM -0400, Jeff Layton wrote:
> > Currently the CB_RECALL_ANY job takes a cl_rpc_users reference to
> > the
> > client. While a callback job is technically an RPC that counter is
> > really more for client-driven RPCs, and this has the effect of
> > preventing the client from being unhashed until the callback
> > completes.
> >=20
> > If nfsd decides to send a CB_RECALL_ANY just as the client reboots,
> > we
> > can end up in a situation where the callback can't complete on the
> > (now
> > dead) callback channel, but the new client can't connect because
> > the old
> > client can't be unhashed. This usually manifests as a NFS4ERR_DELAY
> > return on the CREATE_SESSION operation.
> >=20
> > The job is only holding a reference to the client so it can clear a
> > flag
> > in the after the RPC completes. Fix this by having CB_RECALL_ANY
> > instead
> > hold a reference to the cl_nfsdfs.cl_ref. Typically we only take
> > that
> > sort of reference when dealing with the nfsdfs info files, but it
> > should
> > work appropriately here to ensure that the nfs4_client doesn't
> > disappear.
> >=20
> > Fixes: 44df6f439a17 ("NFSD: add delegation reaper to react to low
> > memory condition")
> > Reported-by: Vladimir Benes <vbenes@redhat.com>
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
>=20
> Applied to nfsd-fixes while waiting for review and testing. Thanks!
>=20
>=20
> > ---
> > Changes in v2:
> > - Clean up the changelog
> > - Add Fixes: tag
> > - Use kref_get instead of kref_get_unless_zero
> > ---
> > =C2=A0fs/nfsd/nfs4state.c | 7 ++-----
> > =C2=A01 file changed, 2 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index 5fcd93f7cb8c..3cef81e196c6 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -3042,12 +3042,9 @@ static void
> > =C2=A0nfsd4_cb_recall_any_release(struct nfsd4_callback *cb)
> > =C2=A0{
> > =C2=A0	struct nfs4_client *clp =3D cb->cb_clp;
> > -	struct nfsd_net *nn =3D net_generic(clp->net, nfsd_net_id);
> > =C2=A0
> > -	spin_lock(&nn->client_lock);
> > =C2=A0	clear_bit(NFSD4_CLIENT_CB_RECALL_ANY, &clp->cl_flags);
> > -	put_client_renew_locked(clp);
> > -	spin_unlock(&nn->client_lock);
> > +	drop_client(clp);
> > =C2=A0}
> > =C2=A0
> > =C2=A0static int
> > @@ -6616,7 +6613,7 @@ deleg_reaper(struct nfsd_net *nn)
> > =C2=A0		list_add(&clp->cl_ra_cblist, &cblist);
> > =C2=A0
> > =C2=A0		/* release in nfsd4_cb_recall_any_release */
> > -		atomic_inc(&clp->cl_rpc_users);
> > +		kref_get(&clp->cl_nfsdfs.cl_ref);
> > =C2=A0		set_bit(NFSD4_CLIENT_CB_RECALL_ANY, &clp-
> > >cl_flags);
> > =C2=A0		clp->cl_ra_time =3D ktime_get_boottime_seconds();
> > =C2=A0	}
> >=20
> > ---
> > base-commit: 05258a0a69b3c5d2c003f818702c0a52b6fea861
> > change-id: 20240405-rhel-31513-028ab6f14252
> >=20
> > Best regards,
> > --=20
> > Jeff Layton <jlayton@kernel.org>
> >=20
> >=20
>=20
Hi,=20
I've just finished the testing of the new patch on the same HW
configuration and the dracut test suite is stable again.

Thank you for your patches!
Vladimir Benes

Tested-by: Vladimir Benes <vbenes@redhat.com>







