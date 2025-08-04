Return-Path: <linux-nfs+bounces-13416-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB519B1A9FD
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Aug 2025 22:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81A2F3BF750
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Aug 2025 20:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5B11E0B9C;
	Mon,  4 Aug 2025 20:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XZ35oL6E"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6229C213245
	for <linux-nfs@vger.kernel.org>; Mon,  4 Aug 2025 20:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754337933; cv=none; b=cRCT11Ec3RwMbDHgjuNTUFSCNv1bE0VmFi0qcyAduukzNf0XSNZctZqVsxJtVndhdBh1WADsK/BNbwhKEwuhigQRjKXwH3OSRf2TTX6LS+b07iecEV834lFhcx+J+fd5KfdAnqmZos7x4VcDDFao6ajiTWA3Cd3s2DjKJZTz9Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754337933; c=relaxed/simple;
	bh=nN7DCn97m/9TbPIrv6sKOWWNwNtFYv9+luLgxnam1CU=;
	h=From:Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:
	 References:In-Reply-To; b=a+q1ndKAQ3375Ervi2N/vX5tdAw37PBvFAx3QCPMxySDsr4FA9fetpX5gdQ/fljIz4ba9rhaxpuP+llbUinesI+SbOn7hhtcxlTsmW9RRACwnsWMQxtbBgKvRQ+olpaB0EvgXI+LyYxYpTF+HJ1VkUSiS1h3JSL6cZ0NDRpsjSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XZ35oL6E; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-458b885d6eeso14587285e9.3
        for <linux-nfs@vger.kernel.org>; Mon, 04 Aug 2025 13:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1754337928; x=1754942728; darn=vger.kernel.org;
        h=in-reply-to:references:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YmPG0FKm2eAyzDHde4Egrl0xCMz2N9w7HJrELY6R1t0=;
        b=XZ35oL6Ewk7+jd6cyUVe/3z+gQLAekFwGmYs+7cHpSKZwpyE2mFqsbqcN8U759tV9M
         UD/DfXK4CeB7vAnFFyQFrSA+qhXVG1DlKcG2q6Jjp3hvjz0npO4OJ1y6zhBnrBPgLxFH
         WYmJsyY1+0vYrLn1OKOCs9MlENts+vWCEEul6cAuHw1Q3OFnBd9yn7M6I5DktqwLtrPn
         jsZoIuBFDgvZXC1Bmgg/BgO4T8/GvI6f0XcvdfOjXXyTDjq4j1nuuSQPFPeYhSu90Rln
         8Aepr96UHC70ti4J81mfm+nTQ0fOThTKj9Gy2014ct0bcCVTRbOoDMX7C4rcoLc7hXXF
         Ttig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754337928; x=1754942728;
        h=in-reply-to:references:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YmPG0FKm2eAyzDHde4Egrl0xCMz2N9w7HJrELY6R1t0=;
        b=TvFT7XOzS0IQlZgExNexRdeNYI7SGylq/rCrHEi1ptGfC3vxD0+OACHeCCR1tYG7CM
         3rzuzfAM7TWHIZsRy0LB99XKQtkvrgMdpT58QGnoPd8SR+Vd5+PO3a1g4wGf1bD0VNY4
         nYgupM0yClHxxfhj6pvGIJthDCoRmewlPwYeCS/oh5zoIbOeMfaF1scuvAFjoC7DWgan
         fsfO5NfUdQO0jvgY0i/999t8YPyEJ1yriZknxnkYkHDUgl+mf8bNpZYxoO/Co04eYL4z
         KFGD/n510LhQrYw2zvb3WUgTzPrUHxN8ddYZ6Mxee9pDN1AqMaE4JYZdjyiN5nNfcgEM
         qyvA==
X-Forwarded-Encrypted: i=1; AJvYcCUj7DMJ21b9RHeM+TwuYZQjQwuEA/s8FUy76z0xU21NiCxqzjpbAABYOgRv3x7psF6jGJH2KwOY+s4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6Ckab1tfS7p1wPWMGWPKaezsKEjXm8U+7rpmI7jAfXcfSA0Uo
	kZiZ+xGv9n7uJKQvqZQzvzK22w7xsZ7U8tBCnwNou+nfo6IB6EDlc6ExaA6syF8SXGs=
X-Gm-Gg: ASbGncvFLak1/3iQoEoXRTT2ImVv7whY9iZBi4PAY8FF+QOXhQWFltSroi40qdVhclU
	2VbF5tRca9TsQ6IRWekkQ3Cfen/9+J3/0Ttd6H+ZSDLPMB6ZLXKKJ+dp44FjaRI3/cylYFeyL5+
	f27Ir6441AwhhR5Dj/iJ5Xqjyu34BlLG3a1rMzessocg0h2eRT52J7iC6plYpPi7qk99/zSgOG8
	Fljqf6IQXWfA51erocl2h/ViUjDYesnE7gXfAt+eozMzbfqV5O3mWyXFvcVa8Oetoj1o0DiZNWD
	1KEt0mLs4EVL9p39SBJrBQfyUojpaMWZo+bTV3JUSKJiujXpbst84kb79Pj1SAkBDnPXCS6zA7k
	ysRa/JTt4aQ==
X-Google-Smtp-Source: AGHT+IH0Tm5gj2pfB1FVxEPIxds22Zf0DAyL9qwR/YYyJRPBbokvT/sTG6pJsqWLZ4dzh0YZml/s8g==
X-Received: by 2002:a05:6000:228a:b0:3b7:9233:ebb with SMTP id ffacd0b85a97d-3b8d946a592mr6970538f8f.6.1754337928474;
        Mon, 04 Aug 2025 13:05:28 -0700 (PDT)
Received: from localhost ([177.94.120.255])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-53936b15df5sm2998456e0c.3.2025.08.04.13.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 13:05:28 -0700 (PDT)
From: rbm@suse.com
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 04 Aug 2025 17:05:22 -0300
Message-Id: <DBTWW3QOSI3I.2LBV7VWPR4C0B@suse.com>
Subject: Re: [PATCH 1/1] rpc_test.sh: Check for rpcbind remote calls support
Cc: "Steve Dickson" <steved@redhat.com>,
 =?utf-8?b?UmljYXJkbyBCIC4gTWFybGnDqHJl?= <rbm@suse.com>,
 <linux-nfs@vger.kernel.org>, <libtirpc-devel@lists.sourceforge.net>
To: "Petr Vorel" <pvorel@suse.cz>, <ltp@lists.linux.it>
X-Mailer: aerc 0.20.1-80-g1fe8ed687c05-dirty
References: <20250804184850.313101-1-pvorel@suse.cz>
In-Reply-To: <20250804184850.313101-1-pvorel@suse.cz>

On Mon Aug 4, 2025 at 3:48 PM -03, Petr Vorel wrote:
> client binaries rpc_pmap_rmtcall and tirpc_rpcb_rmtcall require rpcbind
> compiled with remote calls.  rpcbind has disabled remote calls by
> default in 1.2.5. But this was not detectable until 1.2.8, which brought
> this info in -v flag.
>
> Detect the support and skip on these 2 functions when disabled.
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Hi,
>
> BTW it'd be nice to investigate why the broadcast functions fail,
> enabling remote calls does not help, testing on:
> ./configure --enable-libwrap --enable-warmstarts --enable-debug --with-st=
atedir=3D/run/rpcbind --with-rpcuser=3Drpc --with-systemdsystemunitdir=3D/u=
sr/lib/systemd/system '--with-nss-modules=3Dfiles usrfiles' --enable-rmtcal=
ls

But did you start the daemon with `-r`? e.g.

# /sbin/rpcbind -f -w -r &

>
> Kind regards,
> Petr
>
> # PATH=3D"/opt/ltp/testcases/bin:$PATH" ./rpc_test.sh -s rpc_svc_1 -c rpc=
_clnt_broadcast
> rpc_test.sh -s rpc_svc_1 -c rpc_clnt_broadcast
> rpc_test 1 TINFO: Running: rpc_test.sh -s rpc_svc_1 -c rpc_clnt_broadcast
> rpc_test 1 TINFO: Tested kernel: Linux ts 6.13.6-1-default #1 SMP PREEMPT=
_DYNAMIC Mon Mar 10 08:49:24 UTC 2025 (495d82a) x86_64 x86_64 x86_64 GNU/Li=
nux
> rpc_test 1 TINFO: initialize 'lhost' 'ltp_ns_veth2' interface
> rpc_test 1 TINFO: add local addr 10.0.0.2/24
> rpc_test 1 TINFO: add local addr fd00:1:1:1::2/64
> rpc_test 1 TINFO: initialize 'rhost' 'ltp_ns_veth1' interface
> rpc_test 1 TINFO: add remote addr 10.0.0.1/24
> rpc_test 1 TINFO: add remote addr fd00:1:1:1::1/64
> rpc_test 1 TINFO: Network config (local -- remote):
> rpc_test 1 TINFO: ltp_ns_veth2 -- ltp_ns_veth1
> rpc_test 1 TINFO: 10.0.0.2/24 -- 10.0.0.1/24
> rpc_test 1 TINFO: fd00:1:1:1::2/64 -- fd00:1:1:1::1/64
> rpc_test 1 TINFO: timeout per run is 0h 5m 0s
> rpc_test 1 TINFO: check registered RPC with rpcinfo
> rpc_test 1 TINFO: registered RPC:
>    program vers proto   port  service
>     100000    4   tcp    111  portmapper
>     100000    3   tcp    111  portmapper
>     100000    2   tcp    111  portmapper
>     100000    4   udp    111  portmapper
>     100000    3   udp    111  portmapper
>     100000    2   udp    111  portmapper
>     100005    1   udp  20048  mountd
>     100024    1   udp  36235  status
>     100005    1   tcp  20048  mountd
>     100024    1   tcp  60743  status
>     100005    2   udp  20048  mountd
>     100005    2   tcp  20048  mountd
>     100005    3   udp  20048  mountd
>     100005    3   tcp  20048  mountd
>     100003    3   tcp   2049  nfs
>     100003    4   tcp   2049  nfs
>     100227    3   tcp   2049  nfs_acl
>     100021    1   udp  40939  nlockmgr
>     100021    3   udp  40939  nlockmgr
>     100021    4   udp  40939  nlockmgr
>     100021    1   tcp  38047  nlockmgr
>     100021    3   tcp  38047  nlockmgr
>     100021    4   tcp  38047  nlockmgr
> rpc_test 1 TINFO: using libtirpc: yes
> rpc_test 1 TFAIL: rpc_clnt_broadcast 10.0.0.2 536875000 failed unexpected=
ly
> RPC: Timed out
> 1
> rpc_test 2 TINFO: SELinux enabled in enforcing mode, this may affect test=
 results
> rpc_test 2 TINFO: it can be disabled with TST_DISABLE_SELINUX=3D1 (requir=
es super/root)
> rpc_test 2 TINFO: loaded SELinux profiles: none
>
>
>
>  testcases/network/rpc/rpc-tirpc/rpc_test.sh | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/testcases/network/rpc/rpc-tirpc/rpc_test.sh b/testcases/netw=
ork/rpc/rpc-tirpc/rpc_test.sh
> index cadae55203..1a8cf46399 100755
> --- a/testcases/network/rpc/rpc-tirpc/rpc_test.sh
> +++ b/testcases/network/rpc/rpc-tirpc/rpc_test.sh
> @@ -53,6 +53,11 @@ setup()
>  		fi
>  	fi
> =20
> +	if [ "$CLIENT" =3D 'rpc_pmap_rmtcall' -o "$CLIENT" =3D 'tirpc_rpcb_rmtc=
all' ] && \
> +		rpcbind -v 2>/dev/null && rpcbind -v 2>&1 | grep -q 'remote calls: no'=
; then
> +		tst_brk TCONF "skip due rpcbind compiled without remote calls"
> +	fi
> +

Reviewed-by: Ricardo B. Marli=C3=A8re <rbm@suse.com>

Thanks!

>  	[ -n "$CLIENT" ] || tst_brk TBROK "client program not set"
>  	tst_check_cmds $CLIENT $SERVER || tst_brk TCONF "LTP compiled without T=
I-RPC support?"
> =20


