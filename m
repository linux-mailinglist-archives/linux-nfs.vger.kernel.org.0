Return-Path: <linux-nfs+bounces-2694-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E9289ACB9
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Apr 2024 21:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4E6FB21D1B
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Apr 2024 19:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E5D487A5;
	Sat,  6 Apr 2024 19:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cdhcEtq9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BF62FE0F
	for <linux-nfs@vger.kernel.org>; Sat,  6 Apr 2024 19:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712430936; cv=none; b=VZuU8qr/E0enFkyY/tYv3LgeBzU1FrFngPEMFZib60FnLorLaL0RkDiuE7zdxVUbKNv4/Cv9afKKIiwSD9+OoEA/yFKV8BPz7WMdHHj6zder1iF8ZmtErn2a4MQ5XjE3UJWkVgruqllsS+Z5QEPcKhutqnGtIZveU+57Gk0ncWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712430936; c=relaxed/simple;
	bh=PgWhdyX72WVPSxvQDrulJAeu3htY5a2avvPTH9QZZsw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dtR7aa3GYUGOG+PhKC4QejUffdl39YOuroS4X+JoI4D1nUNmLPehYLD5qg8nzmOLc139LtFv/wHmpk+nk/TU+oXBA2rfOrF0ljxAgnbLLv2vGMJIv8iNA2/cBL1rtSBVUWMbyiKJQdNo5ovgVhzSY4Q4cf+Me2KZYmgJ0fgQO4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cdhcEtq9; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d8129797fcso42650351fa.1
        for <linux-nfs@vger.kernel.org>; Sat, 06 Apr 2024 12:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712430933; x=1713035733; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=98Ef+vk8ob4APVWlt6WB+jo8JYa0pLwxZsztyhERNkk=;
        b=cdhcEtq93DAXynYdsxMkhmBFKI+OyyQvNQfKEdKUZFEuDIB1uwkoKUlJz7YNsie6tS
         vI5DD95fQcFThyOwCam6a8GBt8eztCKGF9nSzdB1wxcbRDl6ketvlALpskg5mEKRMezD
         ZQJN2yzsCxd/nsZEV3o2ZBaoumVBDJ0vlI1PaE47Rm4u5Z6Cfvu5ah/PULLHOTDKmrZD
         zippCaFRh7FP0PP8X85CzQjN52yF+v05uH1GNISnVycCZeT/T1xN27gck4eJlhyqZQOx
         eWdMMMnaCSj4eFvdrACtWpfPo9dsOb87bHQFCK5EaKJkCpXdX+4v28HUe5HW+cfUHZez
         M9gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712430933; x=1713035733;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=98Ef+vk8ob4APVWlt6WB+jo8JYa0pLwxZsztyhERNkk=;
        b=jDuIlBeZ1oTXy6DNxeorjHc4MEvjT7u+3TH4XE+2Efoti4rcZ70jQGyPmrpgOzE7Xz
         qUl2pchbfVQXQWUNSrshiExAOicorRTJ4MKzz5qa7VHfMMZbJaNWKk7gWo5GQ2ITA2o0
         dgNoMAxrXta+CwVIlnP01C1VWn2NkSYaDEo9dGX+3X+63xYdy0pGixrsrX1wn0FYFgoz
         52THQFn7zedWcotSbnIK4r/ckLqI0g+E9b4uH6DAEITrBONSkYj4sLpl6Np65HvqFWVB
         O5x90touVNAKvIcRjVGTqAeWNL7e4EHIHPc1OKDqwUM+Zv9FTvF73ciM2HjZEAQA6VIy
         YI5Q==
X-Forwarded-Encrypted: i=1; AJvYcCU2yjScB3VbZFx27q0wWSNk+0gCQlYv0qjoWgmSlFAlNIxFNKCGwUlAPI7rmuuYZYswdChD2YAuIAOtaSPlcPMm7odApgwi13FY
X-Gm-Message-State: AOJu0YwTMfL2SRs15sojGVvEfUJlYV7D6WQtFlkKgR5/sEFP3/77R5nL
	iRYxOD8AaAyFyfyWDul8VVdA5kg72s4Mu6uoQ2UcNokXUfNTTkw4
X-Google-Smtp-Source: AGHT+IFkgHEEUuj7kUPPYNgkdSHvymCWiwPx/UaNCLFOdGQeLpavPM3c8ICVY4zYKZzWRulT8MqvHg==
X-Received: by 2002:a2e:9194:0:b0:2d8:635d:56bc with SMTP id f20-20020a2e9194000000b002d8635d56bcmr3651748ljg.23.1712430932190;
        Sat, 06 Apr 2024 12:15:32 -0700 (PDT)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id dy26-20020a05640231fa00b0056dbd754811sm2168073edb.40.2024.04.06.12.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Apr 2024 12:15:31 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 9BC44BE2EE8; Sat, 06 Apr 2024 21:15:30 +0200 (CEST)
Date: Sat, 6 Apr 2024 21:15:30 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Chuck Lever <chuck.lever@oracle.com>, Steve Dickson <steved@redhat.com>,
	linux-nfs@vger.kernel.org
Cc: 1067829@bugs.debian.org, 1067829-submitter@bugs.debian.org,
	Vladimir Petko <vladimir.petko@canonical.com>
Subject: Fails to build on arm{el,hf} =?utf-8?Q?wit?=
 =?utf-8?Q?h_64bit_time=5Ft=3A_export-cache=2Ec=3A110=3A51=3A_error=3A_for?=
 =?utf-8?B?bWF0IOKAmCVsZOKAmSBleHBlY3RzIGFyZ3VtZW50IG9mIHR5cGUg4oCYbG9u?=
 =?utf-8?Q?g_int=E2=80=99=2C_but_argument_4_has_type_=E2=80=98time=5Ft?=
 =?utf-8?B?4oCZIHtha2Eg4oCYbG9uZyBsb25nIGludOKAmX0=?= [-Werror=format=]
Message-ID: <ZhGfUpXclZeoZ_az@eldamar.lan>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="BZMOUUH4Akr1GN1D"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit


--BZMOUUH4Akr1GN1D
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Chuck, hi Steve,

In Debian, as you might have heard there is a 64bit time_t
transition[1] ongoing affecting the armel and armhf architectures.
While doing so, nfs-utils was found to fail to build for those
architectures after the switch, reported in Debian as [2]. Vladimir
Petko from Ubuntu has as well filled it in [3].

 [1]: https://lists.debian.org/debian-devel-announce/2024/02/msg00005.html
 [2]: https://bugs.debian.org/1067829
 [3]: https://bugzilla.kernel.org/show_bug.cgi?id=218540

The report is full-quoted below. 

Vladimir Petko has created a patch in the bugzilla which I'm attaching
here as well. If this is not an acceptable format due to missing
Signed-off's I'm attaching a variant with a Suggested-by for Vladimir
to properly credit the patch origin.

Let me know if that works. I changed it slightly and only casting to
long long, and made it almost checkpatch clean.

Regards,
Salvatore

----- Forwarded message from Sebastian Ramacher <sramacher@debian.org> -----

From: Sebastian Ramacher <sramacher@debian.org>
Resent-From: Sebastian Ramacher <sramacher@debian.org>
Reply-To: Sebastian Ramacher <sramacher@debian.org>, 1067829@bugs.debian.org
Date: Wed, 27 Mar 2024 11:02:25 +0100
To: Debian Bug Tracking System <submit@bugs.debian.org>
Subject: Bug#1067829: nfs-utils: FTBFS on arm{el,hf}: export-cache.c:110:51: error: format ‘%ld’ expects argument of
	type ‘long int’, but argument 4 has type ‘time_t’ {aka ‘long long int’} [-Werror=format=]
Delivered-To: submit@bugs.debian.org
Message-ID: <ZgPusfnkCCvhalve@ramacher.at>

Source: nfs-utils
Version: 1:2.6.4-3
Severity: serious
Tags: ftbfs
Justification: fails to build from source (but built successfully in the past)
X-Debbugs-Cc: sramacher@debian.org

https://buildd.debian.org/status/fetch.php?pkg=nfs-utils&arch=armel&ver=1%3A2.6.4-3%2Bb2&stamp=1711452552&raw=0

libtool: compile:  gcc -DHAVE_CONFIG_H -I. -I../../support/include -I/usr/include/tirpc -I/usr/include/libxml2 -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64 -D_TIME_BITS=64 -Wdate-time -D_FORTIFY_SOURCE=2 -D_GNU_SOURCE -pipe -Wall -Wextra -Werror=strict-prototypes -Werror=missing-prototypes -Werror=missing-declarations -Werror=format=2 -Werror=undef -Werror=missing-include-dirs -Werror=strict-aliasing=2 -Werror=init-self -Werror=implicit-function-declaration -Werror=return-type -Werror=switch -Werror=overflow -Werror=parentheses -Werror=aggregate-return -Werror=unused-result -fno-strict-aliasing -Werror=format-overflow=2 -Werror=int-conversion -Werror=incompatible-pointer-types -Werror=misleading-indentation -Wno-cast-function-type -g -O2 -Werror=implicit-function-declaration -ffile-prefix-map=/<<PKGBUILDDIR>>=. -fstack-protector-strong -fstack-clash-protection -Wformat -Werror=format-security -c xml.c  -fPIC -DPIC -o .libs/xml.o
export-cache.c: In function ‘junction_flush_exports_cache’:
export-cache.c:110:51: error: format ‘%ld’ expects argument of type ‘long int’, but argument 4 has type ‘time_t’ {aka ‘long long int’} [-Werror=format=]
  110 |         snprintf(flushtime, sizeof(flushtime), "%ld\n", now);
      |                                                 ~~^     ~~~
      |                                                   |     |
      |                                                   |     time_t {aka long long int}
      |                                                   long int
      |                                                 %lld
libtool: compile:  gcc -DHAVE_CONFIG_H -I. -I../../support/include -I/usr/include/tirpc -I/usr/include/libxml2 -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64 -D_TIME_BITS=64 -Wdate-time -D_FORTIFY_SOURCE=2 -D_GNU_SOURCE -pipe -Wall -Wextra -Werror=strict-prototypes -Werror=missing-prototypes -Werror=missing-declarations -Werror=format=2 -Werror=undef -Werror=missing-include-dirs -Werror=strict-aliasing=2 -Werror=init-self -Werror=implicit-function-declaration -Werror=return-type -Werror=switch -Werror=overflow -Werror=parentheses -Werror=aggregate-return -Werror=unused-result -fno-strict-aliasing -Werror=format-overflow=2 -Werror=int-conversion -Werror=incompatible-pointer-types -Werror=misleading-indentation -Wno-cast-function-type -g -O2 -Werror=implicit-function-declaration -ffile-prefix-map=/<<PKGBUILDDIR>>=. -fstack-protector-strong -fstack-clash-protection -Wformat -Werror=format-security -c display.c -o display.o >/dev/null 2>&1
cc1: some warnings being treated as errors
make[3]: *** [Makefile:489: export-cache.lo] Error 1
make[3]: *** Waiting for unfinished jobs....

Cheers
-- 
Sebastian Ramacher

----- End forwarded message -----

--BZMOUUH4Akr1GN1D
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="armhf-time-t-format-error.patch"

Description: cast to a type with a known size to ensure sprintf works
Author: Vladimir Petko <vladimir.petko@canonical.com>
Bug: https://bugzilla.kernel.org/show_bug.cgi?id=218540
Bug-Ubuntu:  https://bugs.launchpad.net/ubuntu/+source/nfs-utils/+bug/2055349
Last-Update: 2024-02-29
--- a/support/junction/export-cache.c
+++ b/support/junction/export-cache.c
@@ -107,7 +107,7 @@
 		xlog(D_GENERAL, "%s: time(3) failed", __func__);
 		return FEDFS_ERR_SVRFAULT;
 	}
-	snprintf(flushtime, sizeof(flushtime), "%ld\n", now);
+	snprintf(flushtime, sizeof(flushtime), "%lld\n", (long long int)now);
 
 	for (i = 0; junction_proc_files[i] != NULL; i++) {
 		retval = junction_write_time(junction_proc_files[i], flushtime);

--BZMOUUH4Akr1GN1D
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment;
	filename="0001-junction-export-cache-cast-to-a-type-with-a-known-si.patch"
Content-Transfer-Encoding: 8bit

From 774394df352c249775d51d5d6e3effa775096b4f Mon Sep 17 00:00:00 2001
From: Salvatore Bonaccorso <carnil@debian.org>
Date: Sat, 6 Apr 2024 20:48:43 +0200
Subject: [PATCH] junction: export-cache: cast to a type with a known size to
 ensure sprintf works
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

As reported in Debian, with the 64bit time_t transition for the armel
and armhf architecture, it was found that nfs-utils fails to compile
with:

	libtool: compile:  gcc -DHAVE_CONFIG_H -I. -I../../support/include -I/usr/include/tirpc -I/usr/include/libxml2 -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64 -D_TIME_BITS=64 -Wdate-time -D_FORTIFY_SOURCE=2 -D_GNU_SOURCE -pipe -Wall -Wextra -Werror=strict-prototypes -Werror=missing-prototypes -Werror=missing-declarations -Werror=format=2 -Werror=undef -Werror=missing-include-dirs -Werror=strict-aliasing=2 -Werror=init-self -Werror=implicit-function-declaration -Werror=return-type -Werror=switch -Werror=overflow -Werror=parentheses -Werror=aggregate-return -Werror=unused-result -fno-strict-aliasing -Werror=format-overflow=2 -Werror=int-conversion -Werror=incompatible-pointer-types -Werror=misleading-indentation -Wno-cast-function-type -g -O2 -Werror=implicit-function-declaration -ffile-prefix-map=/<<PKGBUILDDIR>>=. -fstack-protector-strong -fstack-clash-protection -Wformat -Werror=format-security -c xml.c  -fPIC -DPIC -o .libs/xml.o
	export-cache.c: In function ‘junction_flush_exports_cache’:
	export-cache.c:110:51: error: format ‘%ld’ expects argument of type ‘long int’, but argument 4 has type ‘time_t’ {aka ‘long long int’} [-Werror=format=]
	  110 |         snprintf(flushtime, sizeof(flushtime), "%ld\n", now);
	      |                                                 ~~^     ~~~
	      |                                                   |     |
	      |                                                   |     time_t {aka long long int}
	      |                                                   long int
	      |                                                 %lld

time_t is not guaranteed to be 64-bit, so it must be coerced into the expected
type for printf. Cast it to long long.

Reported-by: Vladimir Petko <vladimir.petko@canonical.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218540
Link: https://bugs.debian.org/1067829
Link: https://bugs.launchpad.net/ubuntu/+source/nfs-utils/+bug/2055349
Fixes: 494d22396d3d ("Add LDAP-free version of libjunction to nfs-utils")
Suggested-by: Vladimir Petko <vladimir.petko@canonical.com>
Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
---
 support/junction/export-cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/support/junction/export-cache.c b/support/junction/export-cache.c
index 4e578c9b37b1..00187c019d60 100644
--- a/support/junction/export-cache.c
+++ b/support/junction/export-cache.c
@@ -107,7 +107,7 @@ junction_flush_exports_cache(void)
 		xlog(D_GENERAL, "%s: time(3) failed", __func__);
 		return FEDFS_ERR_SVRFAULT;
 	}
-	snprintf(flushtime, sizeof(flushtime), "%ld\n", now);
+	snprintf(flushtime, sizeof(flushtime), "%lld\n", (long long)now);
 
 	for (i = 0; junction_proc_files[i] != NULL; i++) {
 		retval = junction_write_time(junction_proc_files[i], flushtime);
-- 
2.43.0


--BZMOUUH4Akr1GN1D--

