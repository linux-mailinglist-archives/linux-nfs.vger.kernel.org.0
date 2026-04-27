Return-Path: <linux-nfs+bounces-21171-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMD3BpxQ72kEAAEAu9opvQ
	(envelope-from <linux-nfs+bounces-21171-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 14:03:40 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BAFA5472390
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 14:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 737AB3040A8F
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 12:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10DE83B38B8;
	Mon, 27 Apr 2026 12:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L1Qji05Y"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE0B3B0AD4
	for <linux-nfs@vger.kernel.org>; Mon, 27 Apr 2026 12:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777291342; cv=pass; b=hpby9piNrXhhTJPEZxUJ9TnVoJ6I/wHT1eR+gfQ4/X9lm/pAihzo7HeRfnAWgvugyK4zzFOrCq83wxjq+5wADi6xfEUD0BS/NGxpT0nkMFhClx5Um/CNg9cVBE70mYBnJ0wvUW5+EwxwIfCP5OERVp7s2BdHdhNROF9TVX2RPTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777291342; c=relaxed/simple;
	bh=f7oNU5FaDQl+Nkbi/6/Ivnlhsv7ogl5Ysmt1I3aNaRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JACKkQFE+EqgFXKNOJYiycxtXVt+z4NTF+jGPFK3YXqH6WBkKY2tNCHBYR5VMmfHNQ9/NNuGy01SwQ6IJ1Et0hk0PQPKMYyC+wyk6fSldMDlBh4fHrT/qgUnA3bZPeLDfeilltLUFMIYYCPyeosL5qel7ieJM7ln9T4nJl6JI6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L1Qji05Y; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-671c24f23b1so14831422a12.0
        for <linux-nfs@vger.kernel.org>; Mon, 27 Apr 2026 05:02:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777291339; cv=none;
        d=google.com; s=arc-20240605;
        b=aIgtHoZ+44pg7twSbn/mYvvHqAKTC2qb7n5hQkEopMDIZ5OgaPnXeFW+TJzJHXbdGu
         7pc/5uR5sqeyEz2IE1lH3Nl1BnAYj20CXpgSu8tbL8Qd1VLb0zHL9Ey/qrMIre2apl9y
         TsqASyvQtLI7i8cSdoa62AAwqhy3CAytgVrttdtmzejZVSIeGVfpqtAdvaqnIzRvtRkI
         B2vnps9O0u8LHnDtvFSU8d8aDX3M2kuNym8ioqxy0FLol0k1+9O7Ok8GOG0RF4CnQVot
         Pemg1sNf9jC6bt0vCjvuGuI0rAJEQGaF+swTRDyCA2khWIHOd4p4agQr4P4W2uitM7o3
         OYrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=bSw1aMO32TuHJYbNOmDfdqPOAHdqlsV6G0A1b+WUvMY=;
        fh=Y3mJpvKBezdMP4XHlbXibwTC9W3n2JjzBhGw95wv4T8=;
        b=f1rg+mOVJ1VvOH3McgkBAwpMjI10mBHWpkHDhnV3jz54ENDK7/71yGsPM0eU7Asz1I
         Xl3ocdIOflN+R0ytPyK5sRarRrNN8BiNsKK/Og7y++J/ROMrlBHxPav/K6u043SRiexJ
         iEAj9hQTcZNfbTI63a5Nk7ywvk/pLDmIUBRrUw20+4wXmhpEoZyQCWB7AWKe/0FpWRHn
         gfoOQ/1+tcLC81ajW6FQ13vm0eutIC7+8dvMSTuzSh0y9hgd1AW7mPJpeenU4uwv0LyX
         CnHmDrZi+8/uk9PbvH4Hl9BlLAsGDs/6JOLWcVyGu/P7tSRh8nWOy7SKTSHuAmSu4GSg
         az3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777291339; x=1777896139; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bSw1aMO32TuHJYbNOmDfdqPOAHdqlsV6G0A1b+WUvMY=;
        b=L1Qji05YBSR2Px1RPMh0Qij8MMdumsVHV5YhEmf2miBD194l4h2f4Z7suJgFn1jtUi
         nzfd7Qh5/RECtOiX7nuAY1uhhuzoTTrXeMLpEZrhbXjht25kKCDiiIthtTp3DVHH5Nqx
         eMrNP697teAtC8Hv70hpPCgecgtZdpvh2VsT5utyY5amkOAKY+Yw0YFGZ/BKhJ1O6/Lw
         qfJ3koSwuyZNC3NIanPJvHA7FAEzxMODU8ZsjqoAInWEwJvYyPQ2vbfnqaO+SOYsAp7/
         a/kbMqdC5MiCHNxJE+BLEO8y0jN6NVDA5IEUYIDJmJJouMA+qdoOSNLNGUIDhH2IoA7V
         DMfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777291339; x=1777896139;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bSw1aMO32TuHJYbNOmDfdqPOAHdqlsV6G0A1b+WUvMY=;
        b=H6mYHWpZDC7ROWEyxACCUU0465edVTrzr+ZaOk6SAIQILAb8i2t7zVYIAZqr4zt0mC
         4TAO8hX2R9CfNUu8NIOq1J4vOVnTwrUPjFwHim/qYfADKq1TQlasAB+c3mMf3e/Drcs6
         8OW3Yyby1kVVxQ1G3GJUssu5dmT3iNwg2gBKeDHTICDXsILNkTW4ZAp12b0KIWrbXXF5
         9IZlMBgWZuAZCCYMDuAPyY6KQcwAH4pfgwjr8WXdhtZ3s11QdZ77fawInhtJnT/fAj+7
         guNoB8cFk4YZK/lPUMyrpVzwREWfNdOnQJM8s5k9FUtaFfIhPPU/i27G/1J365gSoqhi
         OOaQ==
X-Forwarded-Encrypted: i=1; AFNElJ9cNOSlm7KyLCULLyW5dZ8vN3QBh2gbKPUXQQOKp/0etSGYrrlaqYtvWF/vzqNTT6UPuUCi3dsSrAw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2ZwfCxVo5kFPg9mO5fGVSWrb9W+ucGTtxaqu0whh+BVFLjk7k
	hC1a08lgvekW8iHPuj8zYEypsUnCMmQ/J8ciR3N2EppDjXK2JR3NhpcIeF6vYBAxuVtUABjwcX5
	m3rmVzvMEfza74V9kdhhPjULThSxWEmI=
X-Gm-Gg: AeBDieuaBu61ZLlHRlK2nQppBrZB6MujeBBXWDdDYADwgnIuBZ/R95GTRjawJpiq8/0
	XB5uW9s39gtQidni3MDfHH9ZGXWV1F8I1Ze9byGfeVTGPd0WuBDEK0/0AJY3bXZhIxvvj1b7q2o
	MNzqxWJ7GkixWgZwodC34sE+sN2i4OULcBib5Hgvt8nI2sIbggBPCyTQWfVvpJh+eW87YVxFF94
	Jx/3YfyxgLDdXwbq9AMvotL/cstbt8fEnQ3mq3/1+U+ArxED+qWuOEO/iutvumF7+6utaSR/MMS
	JOmyc0/dgq4hcAl1fabbi/AgfEKU
X-Received: by 2002:a05:6402:c46:b0:670:d548:da79 with SMTP id
 4fb4d7f45d1cf-672bfd87175mr18491070a12.3.1777291337998; Mon, 27 Apr 2026
 05:02:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260424-case-sensitivity-v11-0-de5619beddaf@oracle.com>
 <20260424-case-sensitivity-v11-12-de5619beddaf@oracle.com> <isfgwmd5hxjfn7dj7p54yzlhumx2hrkt3zw7fscs2ywm57g3hu@co27drpx24lq>
In-Reply-To: <isfgwmd5hxjfn7dj7p54yzlhumx2hrkt3zw7fscs2ywm57g3hu@co27drpx24lq>
From: Lionel Cons <lionelcons1972@gmail.com>
Date: Mon, 27 Apr 2026 14:02:00 +0200
X-Gm-Features: AVHnY4JzeOH_kK3jDOjK2FxeQTqZ9zkWJjZAaa-9jIyvUG0bleb4vaJ230stvGc
Message-ID: <CAPJSo4WmRu_64TxBsaimWOqz3VAU0TZ1H-_hw36HSqzQULm39w@mail.gmail.com>
Subject: Re: [PATCH v11 12/15] isofs: Implement fileattr_get for case sensitivity
To: Jan Kara <jack@suse.cz>
Cc: Chuck Lever <cel@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	hirofumi@mail.parknet.co.jp, linkinjeon@kernel.org, sj1557.seo@samsung.com, 
	yuezhang.mo@sony.com, almaz.alexandrovich@paragon-software.com, 
	slava@dubeyko.com, glaubitz@physik.fu-berlin.de, frank.li@vivo.com, 
	tytso@mit.edu, adilger.kernel@dilger.ca, cem@kernel.org, sfrench@samba.org, 
	pc@manguebit.org, ronniesahlberg@gmail.com, sprasad@microsoft.com, 
	trondmy@kernel.org, anna@kernel.org, jaegeuk@kernel.org, chao@kernel.org, 
	hansg@kernel.org, senozhatsky@chromium.org, 
	Chuck Lever <chuck.lever@oracle.com>, Roland Mainz <roland.mainz@nrubsig.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: BAFA5472390
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21171-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,zeniv.linux.org.uk,vger.kernel.org,lists.sourceforge.net,mail.parknet.co.jp,samsung.com,sony.com,paragon-software.com,dubeyko.com,physik.fu-berlin.de,vivo.com,mit.edu,dilger.ca,samba.org,manguebit.org,gmail.com,microsoft.com,chromium.org,oracle.com,nrubsig.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lionelcons1972@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,nrubsig.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,archive.org:url,suse.cz:email]

On Mon, 27 Apr 2026 at 12:47, Jan Kara <jack@suse.cz> wrote:
>
> On Fri 24-04-26 21:53:14, Chuck Lever wrote:
> > From: Chuck Lever <chuck.lever@oracle.com>
> >
> > Upper layers such as NFSD need a way to query whether a
> > filesystem handles filenames in a case-sensitive manner so
> > they can provide correct semantics to remote clients. Without
> > this information, NFS exports of ISO 9660 filesystems cannot
> > advertise their filename case behavior.
> >
> > Implement isofs_fileattr_get() to report ISO 9660 case handling
> > behavior via the FS_XFLAG_CASEFOLD flag. The 'check=r' (relaxed)
> > mount option enables case-insensitive lookups, and this setting
> > determines the value reported. By default, Joliet extensions
> > operate in relaxed mode while plain ISO 9660 uses strict
> > (case-sensitive) mode. All ISO 9660 variants are case-preserving,
> > meaning filenames are stored exactly as they appear on the disc.
> >
> > Case handling is a superblock-wide property, so the callback
> > must report the same value for every inode type. Regular files
> > previously had no inode_operations; introduce
> > isofs_file_inode_operations to carry the callback. Symlinks
> > previously shared page_symlink_inode_operations; introduce
> > isofs_symlink_inode_operations, which wires page_get_link
> > alongside the callback, so that fileattr queries on a symlink
> > reach the isofs implementation instead of returning
> > -ENOIOCTLCMD. The flag is set in both fa->fsx_xflags and
> > fa->flags so FS_IOC_FSGETXATTR and FS_IOC_GETFLAGS agree.
> >
> > Reviewed-by: Jan Kara <jack@suse.cz>
> > Reviewed-by: Roland Mainz <roland.mainz@nrubsig.org>
> > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>
> ...
>
> > @@ -281,6 +293,18 @@ const struct file_operations isofs_dir_operations =
> >  const struct inode_operations isofs_dir_inode_operations =
> >  {
> >       .lookup = isofs_lookup,
> > +     .fileattr_get = isofs_fileattr_get,
> > +};
> > +
> > +const struct inode_operations isofs_file_inode_operations =
> > +{
> > +     .fileattr_get = isofs_fileattr_get,
> > +};
> > +
> > +const struct inode_operations isofs_symlink_inode_operations =
> > +{
> > +     .get_link = page_get_link,
> > +     .fileattr_get = isofs_fileattr_get,
> >  };
>
> Hum, I thought casefolding is a directory attribute. At least I don't see
> a big point in reporting it for regular files or symlinks (and then why not
> report it for device nodes or named pipes?). So why did you decide for this
> change?

Where do you see this being a per-directory attribute in
https://web.archive.org/web/20170404043745/http://www.ymi.com/ymi/sites/default/files/pdf/Rockridge.pdf

Lionel

