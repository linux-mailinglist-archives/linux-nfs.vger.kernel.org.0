Return-Path: <linux-nfs+bounces-17717-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE18D0C814
	for <lists+linux-nfs@lfdr.de>; Sat, 10 Jan 2026 00:06:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B3966301D5B0
	for <lists+linux-nfs@lfdr.de>; Fri,  9 Jan 2026 23:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACDCF3375C3;
	Fri,  9 Jan 2026 23:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CMMNvI4D"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1190327FD48
	for <linux-nfs@vger.kernel.org>; Fri,  9 Jan 2026 23:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767999983; cv=none; b=SpPuJF7KJU+jY66yRMWZShbwbACQpDNo77I+829m1lTfE/aPdJncvwPX2/jfOX0J/9ad6B7WblQLkh43Tzhh45Z5bApsl1vA2IKWIsGo4LQYJpriknPhczckm6Iqe/M6463Viic/b+XUmwLxlM6KchvuD2+1sNljQ3UTHCFUguI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767999983; c=relaxed/simple;
	bh=ApTABDh+BdUbxJpZY27S9I6fkAp1uHDXwNbOL3pfk2I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gWqtdtmotSOEoHl8wrxbzVC6nWqYSq+EcSMF/5VB5JDRKmye1ETNJJQzN1G4LrrW2Jw16ECKMI3ly2AtEji4E1DkMcJUUdZOo2h35cGrj9bz1NNP1qfRCWId1T6i+ewyGSqUujpMBPLV9BDfLNgTJ8ZtT3g8ussTPNsM4KR0tOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CMMNvI4D; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-64b9230f564so6785469a12.1
        for <linux-nfs@vger.kernel.org>; Fri, 09 Jan 2026 15:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767999980; x=1768604780; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B4nf4e5q3Xf+aH2HG8uen64//LPZBaEocicPF818sVA=;
        b=CMMNvI4DkxfmQMDSn9s/nEyGlTsUFoXYi2Ngdcr7GrxWw4mTB12yDt7YkRbItgHFqq
         A0BN1WR56W4FE/xiBZE+fPc13soF1IZYKR7TeSDfh+7/FmOfS4MHRFImE7nwBaLi+00n
         AYBex6E3y1tMYuC9nmD+Hc48jTe3+Q+GryQezsyFeFF3X6MSQ/QcX94kfbSNEXjfd0/Z
         gX6BhkfyNuNnDPR8NZXMbKi0l1j59CRGlKz0bs/C1vM6hL++g9UbrthQ7BVC45bYxN5Q
         DiKlNoZHeuQFkf3ZFk0UFJLtDmSTyevElo+RBLGszA9n0+bfxJYYvYSeb0G6XRVCwvj8
         mniQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767999980; x=1768604780;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B4nf4e5q3Xf+aH2HG8uen64//LPZBaEocicPF818sVA=;
        b=ocX11wK/6Fs8OZ5b4EjbzKjo8A6krK4sWVKvD5O7ZblAnoOPQhZxBuJXz5ilgW+Xlr
         d6G2k94OrlCobvokK3S6SS61tXefg4YbshTYQd1YRnHkDy+wHbz5xyO8x7RfqAt0Z/P7
         20bpoVElJNsEf2bAIzlTMi2pNzFU7pAfv4dFb8/LVdmXKtS1kE6aYC8R67/Svzi22AgO
         k/s2s3wZH//0NIB3C+Ej+ot3EBiwqEZ1l7/7l4Mr17fVNBHTYVizPpKZHCNOtF89paQ2
         c9OJ/w8/ZJ+acVMVzCaugdS0fZe/zr4h0KDIMi+P8N0n93jJLrfHxUBYT20fIB4mOUYL
         eAYw==
X-Gm-Message-State: AOJu0YyW8uDcBB6KKyJ4bCdwdiUp8NFFL7Nj8PgmZY980H6s0ieKuh8/
	VxuQ/ANQHYWW582VwXKzbSpBP3pk8a1kjxAw4WVkEp46gFksoAaxM54+GA65GTaerESJSw9MayX
	8Y7Zw3XRiLd0WWdcs41fD6nLOiIAaHQ==
X-Gm-Gg: AY/fxX7Xj230564MkVN/eOI3dm9rKyTtxIiP5+zGaav3tCpX3xMIrJUk6uF/vYT2sr/
	1Ddtpbc0OJncJhYwpIDT08PnkpUyh99abZ5w11EoIovGbWLYv04m8N6RLRwQlSuMU+Yh8MNFtUX
	sKMW/ZAEzhkAxEWyqml+Te+TYgAP5fY76tzLLktBSatvxahfIX+sQSYD5oSngEE01EwiDHura2H
	CEMAN1GaHLL/q5hH+uvhKjCm5r0xFXI2B3WvZ3ZuywFThaK4NCym/tDDjw3D+DXf8IOvVdC5Qwg
	Pn4IBFUBqcNq/dTrxgva5HToWDy5
X-Google-Smtp-Source: AGHT+IHptlW3QdpvyZAs8YM+DyD5+3TkZkB2lBpnyv2pOOVqTAc27L3qqsMnQHvX6M3MM/mSMmDOp0xsFFdIu0gZ2Qw=
X-Received: by 2002:a05:6402:26d1:b0:649:d81b:7b7e with SMTP id
 4fb4d7f45d1cf-65097dea710mr9666545a12.8.1767999980297; Fri, 09 Jan 2026
 15:06:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260102232934.1560-6-rick.macklem@gmail.com> <202601100546.EDWB9nf6-lkp@intel.com>
In-Reply-To: <202601100546.EDWB9nf6-lkp@intel.com>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Fri, 9 Jan 2026 15:06:07 -0800
X-Gm-Features: AZwV_QhfhaaDYVNI4iK_DjcqOv_XohHuIUKyvxyQXwX_aOZy-du5nOnZSMXnDgI
Message-ID: <CAM5tNy4KhHb1avowiBET93OZCwcYKR1KAW+F-Wuj_6G46u6C0Q@mail.gmail.com>
Subject: Re: [PATCH v1 5/7] Make nfs4_server_supports_acls() global
To: kernel test robot <lkp@intel.com>
Cc: linux-nfs@vger.kernel.org, oe-kbuild-all@lists.linux.dev, 
	Rick Macklem <rmacklem@uoguelph.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This should be fixed in the v2 patches I posted.
(It needs the same patch as patch 0001 in the server
series, so I added it to the v2 series.)

rick

On Fri, Jan 9, 2026 at 1:55=E2=80=AFPM kernel test robot <lkp@intel.com> wr=
ote:
>
> Hi,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on trondmy-nfs/linux-next]
> [also build test ERROR on linus/master v6.19-rc4 next-20260109]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/rick-macklem-gmail=
-com/Add-entries-to-the-predefined-client-operations-enum/20260103-073239
> base:   git://git.linux-nfs.org/projects/trondmy/linux-nfs.git linux-next
> patch link:    https://lore.kernel.org/r/20260102232934.1560-6-rick.mackl=
em%40gmail.com
> patch subject: [PATCH v1 5/7] Make nfs4_server_supports_acls() global
> config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20260110=
/202601100546.EDWB9nf6-lkp@intel.com/config)
> compiler: sh4-linux-gcc (GCC) 15.2.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20260110/202601100546.EDWB9nf6-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202601100546.EDWB9nf6-lkp=
@intel.com/
>
> All errors (new ones prefixed by >>):
>
>    fs/nfs/nfs4proc.c: In function 'nfs4_server_supports_acls':
> >> fs/nfs/nfs4proc.c:6083:50: error: 'FATTR4_WORD2_POSIX_DEFAULT_ACL' und=
eclared (first use in this function)
>     6083 |                 return server->attr_bitmask[2] & FATTR4_WORD2_=
POSIX_DEFAULT_ACL;
>          |                                                  ^~~~~~~~~~~~~=
~~~~~~~~~~~~~~~~~
>    fs/nfs/nfs4proc.c:6083:50: note: each undeclared identifier is reporte=
d only once for each function it appears in
> >> fs/nfs/nfs4proc.c:6085:50: error: 'FATTR4_WORD2_POSIX_ACCESS_ACL' unde=
clared (first use in this function); did you mean 'FATTR4_WORD1_TIME_ACCESS=
_SET'?
>     6085 |                 return server->attr_bitmask[2] & FATTR4_WORD2_=
POSIX_ACCESS_ACL;
>          |                                                  ^~~~~~~~~~~~~=
~~~~~~~~~~~~~~~~
>          |                                                  FATTR4_WORD1_=
TIME_ACCESS_SET
>
>
> vim +/FATTR4_WORD2_POSIX_DEFAULT_ACL +6083 fs/nfs/nfs4proc.c
>
>   6071
>   6072  bool nfs4_server_supports_acls(const struct nfs_server *server,
>   6073                                        enum nfs4_acl_type type)
>   6074  {
>   6075          switch (type) {
>   6076          default:
>   6077                  return server->attr_bitmask[0] & FATTR4_WORD0_ACL=
;
>   6078          case NFS4ACL_DACL:
>   6079                  return server->attr_bitmask[1] & FATTR4_WORD1_DAC=
L;
>   6080          case NFS4ACL_SACL:
>   6081                  return server->attr_bitmask[1] & FATTR4_WORD1_SAC=
L;
>   6082          case NFS4ACL_POSIXDEFAULT:
> > 6083                  return server->attr_bitmask[2] & FATTR4_WORD2_POS=
IX_DEFAULT_ACL;
>   6084          case NFS4ACL_POSIXACCESS:
> > 6085                  return server->attr_bitmask[2] & FATTR4_WORD2_POS=
IX_ACCESS_ACL;
>   6086          }
>   6087  }
>   6088
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

