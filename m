Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4ABF414579E
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jan 2020 15:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725870AbgAVOUO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 22 Jan 2020 09:20:14 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39079 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbgAVOUO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 22 Jan 2020 09:20:14 -0500
Received: by mail-wr1-f67.google.com with SMTP id y11so7446102wrt.6;
        Wed, 22 Jan 2020 06:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:content-language
         :thread-index;
        bh=odnlfbvxedcHwvzaTKwKNF5iVHJvzgGKZs+f4uhTfbY=;
        b=Nxo4JAVDWWjxWcaBJ7R+w5aSZB0FJbdshdVCP5DVio7OHL23Bd+6sjIXc0lPBiNWaF
         Dj2+5sSQcedPgKGQxNIi3Ar8kB+ZPy23Yo7LUFjnQl1/x0TfpUv6X6wqZyMTfZFDuvlN
         WR6OtRILHPqzu4ZHXP3n86+hg1++CipAXzyCq4VrVXM8VSzqWbxs39Qu6A2xVhz214lm
         NEhAbFD9jsnuApVnteL65WxoCASNfp6o0/lPmXlLb2GPRS473KgqoP9ocMQjXOvyveJr
         hHMLZnlpQz1RSw1hf5rMR2TH/gVNU/rsBmLfPgEaSJRiY9mvofrk1lrxo6cYUE3ck+Yh
         FmKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:content-language
         :thread-index;
        bh=odnlfbvxedcHwvzaTKwKNF5iVHJvzgGKZs+f4uhTfbY=;
        b=iWdOPrLn0pcKTsRF+UX3TkzkVBHL7+yFgAEPH4ezId+2G0Y/gDrv9zbZ0hjZUiIxow
         s0a0d+k5o5RH3XroJ6ugmj73Xo5jdb+P9MtWcptbITao4KchDURtTILWV+SlT2uVSigF
         Hm73FKEV1EvIZxbnui52HIGfofIxvbW+Y9bai2tOea+x7d3XnFE0VFjvkqEDpp2VgjJP
         AbESBIOMRQXKuisUtD0cOEmpqyXt1gSU8kgM486hvN8I7srxMK3mmNFQd4yXbtw1GwJh
         SkxxHn2hcosP7o4pNNZacCsQg4mDbWF7D5gTx5FjkDCuev1WqQgbJfGBsDPYpW9u3jpz
         0mkQ==
X-Gm-Message-State: APjAAAW/r986YEXl1m0Aw6/fWZZq79wwxCBUH07/ALI4VNWeUTgEchLY
        liRTDhxzWcmXqwcq2e1gRC9QkFk912A=
X-Google-Smtp-Source: APXvYqxXMCagPH7ACZQuJnRY3ckz5tf7Z7cqmlNzon7OzF+oVwLBC1U+byz8fb0maIhABYquDRU+xg==
X-Received: by 2002:a5d:458d:: with SMTP id p13mr11471660wrq.314.1579702811459;
        Wed, 22 Jan 2020 06:20:11 -0800 (PST)
Received: from WINDOWSSS5SP16 ([82.31.89.128])
        by smtp.gmail.com with ESMTPSA id a1sm57206102wrr.80.2020.01.22.06.20.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Jan 2020 06:20:10 -0800 (PST)
From:   "Robert Milkowski" <rmilkowski@gmail.com>
To:     "'Trond Myklebust'" <trondmy@hammerspace.com>,
        <linux-nfs@vger.kernel.org>
Cc:     <anna.schumaker@netapp.com>, <linux-kernel@vger.kernel.org>,
        <chuck.lever@oracle.com>
References: <115c01d5c66d$5dcd7ae0$196870a0$@gmail.com>  <041101d5cd50$e398d720$aaca8560$@gmail.com> <962370db9ae3ba5a17ba390afe7f9de6cea571d4.camel@hammerspace.com>
In-Reply-To: <962370db9ae3ba5a17ba390afe7f9de6cea571d4.camel@hammerspace.com>
Subject: RE: [PATCH v2] NFSv4: try lease recovery on NFS4ERR_EXPIRED
Date:   Wed, 22 Jan 2020 14:20:09 -0000
Message-ID: <06bd01d5d12f$0e2288b0$2a679a10$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-gb
Thread-Index: AQLAInB1/y2S+pDlHaM8/Hn+WlDXpAIdMZh3AfDH9S2l/rsNYA==
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

> -----Original Message-----
> From: Trond Myklebust <trondmy@hammerspace.com>
> Sent: 17 January 2020 17:24
> To: linux-nfs@vger.kernel.org; rmilkowski@gmail.com
> Cc: anna.schumaker@netapp.com; linux-kernel@vger.kernel.org;
> chuck.lever@oracle.com
> Subject: Re: [PATCH v2] NFSv4: try lease recovery on NFS4ERR_EXPIRED
>=20
> On Fri, 2020-01-17 at 16:12 +0000, Robert Milkowski wrote:
> > Anyone please?
> >
> >
> > -----Original Message-----
> > From: Robert Milkowski <rmilkowski@gmail.com>
> > Sent: 08 January 2020 21:48
> > To: linux-nfs@vger.kernel.org
> > Cc: 'Trond Myklebust' <trondmy@hammerspace.com>; 'Chuck Lever'
> > <chuck.lever@oracle.com>; 'Anna Schumaker' =
<anna.schumaker@netapp.com
> > >;
> > linux-kernel@vger.kernel.org
> > Subject: [PATCH v2] NFSv4: try lease recovery on NFS4ERR_EXPIRED
> >
> > From: Robert Milkowski <rmilkowski@gmail.com>
> >
> > Currently, if an nfs server returns NFS4ERR_EXPIRED to open(), etc.
> > we return EIO to applications without even trying to recover.
> >
> > Fixes: 272289a3df72 ("NFSv4: nfs4_do_handle_exception() handle
> > revoke/expiry of a single stateid")
> > Signed-off-by: Robert Milkowski <rmilkowski@gmail.com>
> > ---
> >  fs/nfs/nfs4proc.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c index
> > 76d3716..2478405
> > 100644
> > --- a/fs/nfs/nfs4proc.c
> > +++ b/fs/nfs/nfs4proc.c
> > @@ -481,6 +481,10 @@ static int nfs4_do_handle_exception(struct
> > nfs_server *server,
> >  						stateid);
> >  				goto wait_on_recovery;
> >  			}
> > +			if (state =3D=3D NULL) {
> > +				nfs4_schedule_lease_recovery(clp);
> > +				goto wait_on_recovery;
> > +			}
> >  			/* Fall through */
> >  		case -NFS4ERR_OPENMODE:
> >  			if (inode) {
> > --
> > 1.8.3.1
> >
> >
>=20
> Does this apply to any case other than NFS4ERR_EXPIRED in the specific
> case of nfs4_do_open()? I can't see that it does. It looks to me as if
> the open recovery routines already have their own handling of this =
case.

I only observed the issue with open(). After further
review I think you are right and it only applies to nfs4_do_open().


>=20
> If so, why not just add it as a special case in the nfs4_do_open() =
error
> handling? Otherwise this patch will end up overriding other generic
> cases where we have an inode, but no open state.
>=20

Fair point.
So perhaps, few lines further instead of:

			if (inode) {
...
			if (state =3D=3D NULL) {
					break;
			}

There should be:

			if (inode) {
...
			if (state =3D=3D NULL) {
				nfs4_schedule_lease_recovery(clp);
				goto wait_on_recovery;
			}



This way we know that inode cannot be null at this point, and it's a =
case where both inode and state are NULL.
This would be a little bit more general in case we reach this point.

But if you think it is better to move it to nfs4_do_open() then I've =
just tested the following patch:

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 76d3716..b7c4044 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -3187,6 +3187,11 @@ static struct nfs4_state *nfs4_do_open(struct =
inode *dir,
                        exception.retry =3D 1;
                        continue;
                }
+               if (status =3D=3D -NFS4ERR_EXPIRED) {
+                       =
nfs4_schedule_lease_recovery(server->nfs_client);
+                       exception.retry =3D 1;
+                       continue;
+               }
                if (status =3D=3D -EAGAIN) {
                        /* We must have found a delegation */
                        exception.retry =3D 1;



Please let me know which way you want to proceed and I will submit an =
updated patch.



> Note that _nfs4_do_open() already waits for lease recovery, so we only
> need the call to nfs_schedule_lease_recovery().
>

Yep

--=20
Robert Milkowski

