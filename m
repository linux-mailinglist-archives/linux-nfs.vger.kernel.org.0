Return-Path: <linux-nfs+bounces-21275-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMsvAz8v8mlvogEAu9opvQ
	(envelope-from <linux-nfs+bounces-21275-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Apr 2026 18:18:07 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B59D44979BB
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Apr 2026 18:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0BAA430059BD
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Apr 2026 16:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1F740F8E3;
	Wed, 29 Apr 2026 16:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EcBHG2vR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3279A40B6E0
	for <linux-nfs@vger.kernel.org>; Wed, 29 Apr 2026 16:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777479484; cv=pass; b=PyVmxirjykKwt6WOaNNXnnBFgJLICLY8+SPBmK7Cgx8HYxh4NBN2tG/ZIdpMLlnlua6Q/EnqUZYRosCsY5ly99bHVtr22/GUcr6VGKx1nNKxHQ3bj2Cg+gDcMbHK4jO5QNYAr/BBoIWItL/oCaBSl8LWYbNM4YMdAsayp+y5Ma8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777479484; c=relaxed/simple;
	bh=4/h9br6IbEAaz/sz9bcjR2u2wAVmKHxWIms3HYlChEQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XVw2xsHIUh9/WSg6vAY4CutxhORI/Vk5pWWrG6HxCh3+1thkslbX6CaKxHsBoZ9hIpHtqEOP2cBubnB0BwxDGgQYyaJhCmqh26DXZiqVVpUglsnpyIAtNzBBk2y7aVazhzK2gsKQ8LCBHrWDFoDfrDI+ikxmiLTX0LIeM/0wdfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EcBHG2vR; arc=pass smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-82f351ca23cso6604269b3a.2
        for <linux-nfs@vger.kernel.org>; Wed, 29 Apr 2026 09:18:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777479481; cv=none;
        d=google.com; s=arc-20240605;
        b=U8npCxp6Vmi0cELKzMSSZ2fldP6L0v9BO2gfGTHLOLXYu+ocbJaGe1JmYNaqKWcBTj
         2edoTXrPe1o+z/1Z65F3QyIdPqkkW3sX9enxawoyJm+L0i5jlvajjWdiz4W7uZt4Cklv
         nBhk6b3y+fdJMOt7bLeZmI4FbPb05IuKltUMFNZ/mDcIWjM9vqweOA1CKsTASFyo+DSH
         85duJhCDfiR3iZXEhkPoEJDluwf3LYVYOUQlMj8qr7zso8uSPiho/JHYsj80bcMkvX/D
         n8j5R7KB6DWLFoSZcHD4X9wu0GF4x5p4Cg3A3o5lyFVS6/CPrn8v9zXhJlqKm2bJB3YS
         myXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=byP5WKichQ1HLg3jwHworNVi9zud2jj1BPlndfDJ8aY=;
        fh=Px6qcCjvJ2YNuG1/PIn7aFlB/I335qNohCUuXwpCorw=;
        b=ODYmMA63r7I6F44mbusExCqoRF4mzKm4tB90CMvWxUUVEFNOF63aaPvDzdVduWeUga
         RUa5//s5geGNd9OARD/OXgD3CE1dyc04+JFKCwB1qJjlbdPLKQnRr+AEtWQ2AUI5QAQN
         Ez8FCILWrqokWUofhPcEFS3+r03CJnMXlrBKULLs60I35E0b+hh0Ui0e0t8LkMXYgQaD
         aykFAUSn1bM3wEw1w6zOk+rqty8F0fZAo5hnJSSBAn+Fl4E7Lhm+VnFs66tJquoZAK6y
         DwUgdKyfGX/7Kbn+5Jpk1Uwdd03MzWHcMIEIC4lH2RLs40LFDYOFTQrTS6IjzUc7c7cu
         JFZg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777479481; x=1778084281; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=byP5WKichQ1HLg3jwHworNVi9zud2jj1BPlndfDJ8aY=;
        b=EcBHG2vR6G+vc3bB0t3rtnVauvRCn5jDdkn1Jcn6PfI9btfMGL6T0mnM76ZF7QFlcU
         LbCkl6pPR479Tn7GmrqUx1D1hidWDFZEB2xwZs5qvTbMmVgMBogbd+iIBH/IYOKhBNHH
         xi/cHMaGHbalIWgt4pPZ4+Cch4HSNmShddOyHGvBiddOlP2vbbt/HDPQmLqWJfRGAgrX
         3w8Xpcx5gN668aR1MOWR3BllMtDY1twSAOmQ00+8iGptGCfvwxiAd0JDnx1guBKnA90s
         v852FvvnLWrbWIFzCrh64Jn9taPErZwpwr4tH+S5wQzXDfOQmdvSPPdr0rGTtf2gddHW
         WFWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777479481; x=1778084281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=byP5WKichQ1HLg3jwHworNVi9zud2jj1BPlndfDJ8aY=;
        b=B5HBrMGYuACePJMgeQKmjTD3moiMC9ifWf2rj4BDmwtaXZ3kM1yX1i176OnqJmmL5n
         /NWAEj9pWwMp3NWaD9Gdv19/QCwe/FXDTp5D2P4NBXOkZipk9RYpdac2c5ErC/OF1jN3
         oXF2pAGm90b2tbJH8N3uoE6ymz8mDsSbI4AC06E5M7UyNeKRjgfSFz0HTxgMQCVqpRJ5
         ChJR3HEghvCiPuikrYz9Vof+SRZeCbFLNtr3utxJANMyy5tKUF+Eiu+6tAGl2CaisWnQ
         T6zPbVajvZTZoGCy9e3mhc0/6j3Yueiu8DBQ9RtnLTdBnmAghneBlj9+0ZhrjV4cBDVb
         HMRw==
X-Forwarded-Encrypted: i=1; AFNElJ9y5HQEbsRMgmam/Gi9iEeiTwqqFvNpsamW6kor28AYjtkA4HTgzp+Oz7WVaZlTgrctq/paOY8hTKc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkAW7YOM+xD/wGmekIOXIlEOabWou7NhOfkmuvXbqpemA8IRBJ
	y3qggdtM4JC38DvVAi/7V8F7troCTRzOdbADRIbzo/ciB1x0GYcEmInlVOQkG5FEEfWuDVYIWBF
	Nl+XTynx+/oZFUZ9rrF0z9iyeIpsATq0=
X-Gm-Gg: AeBDietE0rUIZzGFelDHPWni4WJF/bwF/MNRmucoyjv9+imSS8t9Gkhw5Y6jaYK+rYo
	s0xiYQxkRc2A/mphbQIvW4dn5eBCE1HN7nyUImFTZOROc0Rrs/VHll9c5e6GrZ3RRE9A1KpKKN4
	r2E0Dsbqz8DFn+ihvV3QDZhoIn9x3w0POeNpWHLacHbfmL3MKUrY3uTuXjBgMriJoHc6HFHN613
	DZiH5dcNbbf2BcLMdN7FJB22SB058cxFY6HaG6BwxgtB2VSCjMMeXCbS6E8NwsMeIA96k+X8fh8
	Bamr5TX9N4wqKPsig+SYsfYb3urgDPyHZuh6u/bnSDnLODFpajA=
X-Received: by 2002:a05:6a20:5497:b0:3a3:a55f:4055 with SMTP id
 adf61e73a8af0-3a3a55f44d5mr7200643637.54.1777479481283; Wed, 29 Apr 2026
 09:18:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428195919.29794-1-kenner.linuxdev@gmail.com> <d5df5a69-5003-40dd-b23a-c88b6fe315a4@app.fastmail.com>
In-Reply-To: <d5df5a69-5003-40dd-b23a-c88b6fe315a4@app.fastmail.com>
From: kenner azevedi <kenner.linuxdev@gmail.com>
Date: Wed, 29 Apr 2026 12:17:49 -0400
X-Gm-Features: AVHnY4IefPVzwnSdfQHiUGo9XDt7l-uo0C9dw3zjrcgN54eRlGdG8JWD20F6ju0
Message-ID: <CAFHy_waCNk2FmYP1ng=MdinR3N7KeiAjjHhaQFWRqRtCJF=5PA@mail.gmail.com>
Subject: Re: [PATCH] nfs: flexfilelayout: fix unused-but-set variable 'err'
To: Anna Schumaker <anna@kernel.org>
Cc: Trond Myklebust <trondmy@kernel.org>, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jonathan Curley <jcurley@purestorage.com>, 
	Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>, Chuck Lever <chuck.lever@oracle.com>, 
	Mike Snitzer <snitzer@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: B59D44979BB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21275-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kennerlinuxdev@gmail.com,linux-nfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FREEMAIL_FROM(0.00)[gmail.com]

Hi Anna, sure!

The error message is being used as information. If I replace dprintk
with pr_debug("%s: err %d op %d status %u\n", __func__, err, opnum,
status); I am telling the compiler that the variable is being used.
Fixing the warning.

Is this change reasonable?

Regards,

Kenner Azevedo

On Wed, Apr 29, 2026 at 10:50=E2=80=AFAM Anna Schumaker <anna@kernel.org> w=
rote:
>
> Hi Kenner,
>
> On Tue, Apr 28, 2026, at 3:59 PM, Kenner de Azevedo dos Santos Miranda wr=
ote:
> > The variable int err in f_layout_io_track_ds_error() is set but not
> > used in the code.
> >
> > The warning was identified by running make w=3D1:
> >
> >    warning: variable =E2=80=98err=E2=80=99 set but not used
> >
> > I set the (void)err to prevent the warning.
>
> Wouldn't it be better to handle the error instead of ignoring it?
>
> Thanks,
> Anna
>
> >
> > I didn`t test with hardware, i ran again the make w=3D1 and the warning
> > was removed.
> >
> > Signed-off-by: Kenner de Azevedo dos Santos Miranda <kenner.linuxdev@gm=
ail.com>
> > ---
> >  fs/nfs/flexfilelayout/flexfilelayout.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c
> > b/fs/nfs/flexfilelayout/flexfilelayout.c
> > index 8b1559171fe3..d9a0fed41eac 100644
> > --- a/fs/nfs/flexfilelayout/flexfilelayout.c
> > +++ b/fs/nfs/flexfilelayout/flexfilelayout.c
> > @@ -1536,6 +1536,7 @@ static void ff_layout_io_track_ds_error(struct
> > pnfs_layout_segment *lseg,
> >                                      mirror, dss_id, offset, length, st=
atus, opnum,
> >                                      nfs_io_gfp_mask());
> >
> > +     (void)err;
> >       switch (status) {
> >       case NFS4ERR_DELAY:
> >       case NFS4ERR_GRACE:
> > --
> > 2.43.0

