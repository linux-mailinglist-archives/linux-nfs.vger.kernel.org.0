Return-Path: <linux-nfs+bounces-17408-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE65CF02BE
	for <lists+linux-nfs@lfdr.de>; Sat, 03 Jan 2026 17:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C66533002D07
	for <lists+linux-nfs@lfdr.de>; Sat,  3 Jan 2026 16:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ECC3223DEF;
	Sat,  3 Jan 2026 16:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AT6rV5wB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698D43C1F
	for <linux-nfs@vger.kernel.org>; Sat,  3 Jan 2026 16:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767456302; cv=none; b=Zhz+S9wkDHx/BG1iR6q0QsdW2SiYcp5rAlGomC6tQGragl4KrhxhBFNNrhKXwoxR/jyJv1cl2BrX+K79Pnjy5CWWviu9YnQ796doOfWci5RQHMyxv2G98JSRwDMLMS7WuGM0/UK723G9TkkBFyTmEbhRxOMaBXO1pfWPFBrgbGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767456302; c=relaxed/simple;
	bh=qRHbeiv/A6I0MACeJQn78sbIYRJnfphXgKW/rlUw7yA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fcg5lBVqgJ3fKQChAFeQxzs2LFX9xJyXzSWtfc7pHV5m2fGztQPGRwiFfKl9haLqHSH69kN3rz1WIxiJlR0qVL5vW4LKdcSVtAkDi7AuUyw0U009mq1KvThuivnLScCdUr1ymj/Q+ldQ5pGyV0eAGqEADAPVmlK2dUMy/BjMlM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AT6rV5wB; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-64d80a47491so1612636a12.1
        for <linux-nfs@vger.kernel.org>; Sat, 03 Jan 2026 08:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767456299; x=1768061099; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LFLKr5spITWdnAr0PoMW7AEp5ipESSDuj+EKefkgI38=;
        b=AT6rV5wBc231Znxmn+24d6Nd17QG5RQ2O1RR8Ttaz8Qz+MSWE/0Uc9kzs6QwK4UtYL
         gpN6o/QVKdFr6wye0RG7aWVp1HOjtrQEr8GVSjD63OKSw75zMv9rdJJgQg75qRKKfyIv
         g48ByBFk86kWH3wDoANLsK0wxM0H7gh835DfhFW9H8jmQzdmy/SYaF7LlkfmdW0IKsLd
         SzSltyfWMaR95dCQS3QHJzccnkd8B7p9V37e9ITTo0TMhFYy39QcSJ1fyEOcpxrV/64O
         Uv4w1fPvFVg4peJQ/ZLNspzu+/IyNhbYLH5wssdH5dCoz01UyHS2OEmMl7r+nlJOnDJJ
         Nuxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767456299; x=1768061099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LFLKr5spITWdnAr0PoMW7AEp5ipESSDuj+EKefkgI38=;
        b=AfTBCnXbRktSc6/Kp9E1i5NitKo4zBhghSONKI/DmuOo5JLSw+LXkXqglpBjVFSljW
         fdu2w5sctRwywQRMkbFZlFuOIcxWR4CKChtf3xNWMrXrxB+KrEykErJ6YogF4+4mvkhl
         JkWbHE35kWekPKM5gX/aNvjqu37VKjTchzRudWyxAbNob7jYhE+KYi/bxGYzj4V48xJh
         3Cv2D0gxi53lgVg5DYM5TyV5wMj7y1gqEy52Nk+bKx3cboHFf5Wgi+6EvqbVoHv6B1y0
         0zUdHQEFfnFx1p9R1Dw5HXK4CNM5kAwF7uQRN68rDiGKyt3sHkMRWAXwjQa+iR6hkSm7
         xaiA==
X-Gm-Message-State: AOJu0YzCvMXgxRT0rPRB5GkLMwVuycB+ZUzUQ/vrNnbmtk99AibdODsg
	l8WnKSt+673atvAz2mHdmI6cMCL8kPgybOWWyyjaNCShoysf+dB1GI4QlOM8ZBE72j+WxF0dV8S
	C/EeVlge54rP9q3k1QaNXSXQPzVbfmw==
X-Gm-Gg: AY/fxX7GZhbwuyDGhzyhVXUit8H5hbSN2T5qaNMGSpEtrRO//HMxvwPTwhEoow2QBDb
	sj/3WL31acEJmEiOZaE7EiF+NIBMS1QwcAZsRLSlpj49kOlFm/bEW450RasrbywAnCHAD1X5QEK
	2lqcvuiqbjyOtPffd//T6KWKWUpMRs9+DFB4Cuc08tEFeSEzlxyh7bomZ4GGThHizaxgJwvNXd0
	sjGgMIHV5p1zJNa8GQ3tS2wcm5sbGvbi7s7omfr6pzjsA8cYGIiF87+dlGDX8ddTqRsJRV2YURP
	jXqNJBJQnVQNOVx/+sED2D01DGjOTRALyYtE
X-Google-Smtp-Source: AGHT+IH4x1nhpw0xpZLa5d8lfcMRteEnYH5oS+qlteZuWyB6bCwtlDmvUEYjc2hO8vNFFTMEM/Iol8GNJL2/0R3hzzM=
X-Received: by 2002:a05:6402:2706:b0:64b:5851:5e7b with SMTP id
 4fb4d7f45d1cf-64fd4a43a4dmr2736375a12.14.1767456298512; Sat, 03 Jan 2026
 08:04:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260102232934.1560-6-rick.macklem@gmail.com> <202601031506.MX594pma-lkp@intel.com>
In-Reply-To: <202601031506.MX594pma-lkp@intel.com>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Sat, 3 Jan 2026 08:04:46 -0800
X-Gm-Features: AQt7F2ocQPosiLJho2njFNk1mj6fnJMMVq9pBA9JF7oTe097MVdvaQQLXJx9yoY
Message-ID: <CAM5tNy7QUweys+yXO=KZ5TFLDVnBr-Jsd2zrmCL0H7EdJU72PQ@mail.gmail.com>
Subject: Re: [PATCH v1 5/7] Make nfs4_server_supports_acls() global
To: kernel test robot <lkp@intel.com>
Cc: linux-nfs@vger.kernel.org, llvm@lists.linux.dev, 
	oe-kbuild-all@lists.linux.dev, Rick Macklem <rmacklem@uoguelph.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The reason this happens is that this patch series requires
the 0001 patch from the server series.

Should I repost with that patch including in this set as well?

rick

On Sat, Jan 3, 2026 at 6:37=E2=80=AFAM kernel test robot <lkp@intel.com> wr=
ote:
>
> Hi,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on trondmy-nfs/linux-next]
> [also build test ERROR on linus/master v6.16-rc1 next-20251219]
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
> config: x86_64-kexec (https://download.01.org/0day-ci/archive/20260103/20=
2601031506.MX594pma-lkp@intel.com/config)
> compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0=
227cb60147a26a1eeb4fb06e3b505e9c7261)
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20260103/202601031506.MX594pma-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202601031506.MX594pma-lkp=
@intel.com/
>
> All errors (new ones prefixed by >>):
>
> >> fs/nfs/nfs4proc.c:6083:36: error: use of undeclared identifier 'FATTR4=
_WORD2_POSIX_DEFAULT_ACL'
>     6083 |                 return server->attr_bitmask[2] & FATTR4_WORD2_=
POSIX_DEFAULT_ACL;
>          |                                                  ^
> >> fs/nfs/nfs4proc.c:6085:36: error: use of undeclared identifier 'FATTR4=
_WORD2_POSIX_ACCESS_ACL'
>     6085 |                 return server->attr_bitmask[2] & FATTR4_WORD2_=
POSIX_ACCESS_ACL;
>          |                                                  ^
>    fs/nfs/nfs4proc.c:9630:12: warning: variable 'ptr' set but not used [-=
Wunused-but-set-variable]
>     9630 |         unsigned *ptr;
>          |                   ^
>    1 warning and 2 errors generated.
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

