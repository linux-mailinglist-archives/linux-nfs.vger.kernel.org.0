Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC81F6988D5
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Feb 2023 00:41:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjBOXl3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 15 Feb 2023 18:41:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjBOXl2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 15 Feb 2023 18:41:28 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A042E80D
        for <linux-nfs@vger.kernel.org>; Wed, 15 Feb 2023 15:41:26 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id fu4-20020a17090ad18400b002341fadc370so4038163pjb.1
        for <linux-nfs@vger.kernel.org>; Wed, 15 Feb 2023 15:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:cc:date:message-id:subject:mime-version:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yQF3GmSSJFMo2OM4DlITMPHntm/OY5GcT0jPmSl5uqA=;
        b=KlO9g70L6V7elXVWln4RfP7l51J5fzKRmMP9BKv7meub2jtSA4W77gg3YY9KEq4fno
         w9iOQ9J4eCrDY143uBw7fNoFO7dSEaGnBXYspEtScsKL1kOxw6EivUcj+CSd3PGGQKPL
         DZ4tHE8F86CohWof6FY0vwBhtqHqGPZOeL6Xfblq2kmmyUC8p35E6QFZ/U8OCvyI8GjI
         DdlNZBTm1MMGn/ml90SdB3zCp9Zoy3KuEvvQL8XHZ/5k4yFC9/8ksLwzeSGFMKKCVFO/
         YF2zQMi1zr3VwMK036XnGunjPSGDE3i8BiJh0PZeMAW4r3VPVvQxvE7CKihVtRXd/Yt8
         miGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:cc:date:message-id:subject:mime-version:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yQF3GmSSJFMo2OM4DlITMPHntm/OY5GcT0jPmSl5uqA=;
        b=HGKQ3YHChg3zqwntUb3KF6iaTbLBZv4EKJvi8KFyKUTBL5TIA19MjeX+KZGcMEXdKh
         9jO1uF9UwY3iovRcy6NCSG6V9EdsEpGIfoACpcVJY2frEwOBfnl5d2ByQW2/czSx0h/4
         8D+FEdYM5gMet9FCR8C5vgIYOYqAlSQT3ibD4PX9Pxa3ry3j+qVi+aTnopjt/DYjZR94
         Den/xZzwSxHzvgqqunKksh5dYI8ITrmeVo2CI32zXBpKpy9/TwCu9aEQ0wo7KeNq74FT
         xND6qKPm+sItV4MF2Z5Nkd09c8DcdMbW64A7vh3dR30cG8y9+dq9YY9uXFcB7em2bLIN
         rCjw==
X-Gm-Message-State: AO0yUKVUAJ0zxn63Qfjyiwgzc5c8jTNh3mssPbMr5+BeRWseILTv2+c0
        9b0M1rbimr+3NSjftZtW3fzFWGGFpMnKOA==
X-Google-Smtp-Source: AK7set8x21WUKSngJ3VSJ2ga6QK2dBz1OUxZOAlfayfT7ik4/GkBdAMaONDszXf8eJmqWx7L0evHXg==
X-Received: by 2002:a17:903:1106:b0:19a:8811:5dee with SMTP id n6-20020a170903110600b0019a88115deemr4256730plh.35.1676504485822;
        Wed, 15 Feb 2023 15:41:25 -0800 (PST)
Received: from smtpclient.apple (c-73-19-52-228.hsd1.wa.comcast.net. [73.19.52.228])
        by smtp.gmail.com with ESMTPSA id iz11-20020a170902ef8b00b0019a6cce2060sm10210859plb.57.2023.02.15.15.41.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Feb 2023 15:41:25 -0800 (PST)
From:   Enji Cooper <yaneurabeya@gmail.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_17331FF5-EC40-4ED4-8388-EF3023FAE58B";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.300.101.1.3\))
Subject: [PATCH 16/17] Capture build/install errors from subdirs
Message-Id: <2CEC0B19-F230-4E04-99D7-615E49C579DB@gmail.com>
Date:   Wed, 15 Feb 2023 15:41:13 -0800
Cc:     linux-nfs@vger.kernel.org
To:     bfields@fieldses.org
X-Mailer: Apple Mail (2.3731.300.101.1.3)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


--Apple-Mail=_17331FF5-EC40-4ED4-8388-EF3023FAE58B
Content-Type: multipart/mixed;
	boundary="Apple-Mail=_F9CA0CF6-37B6-481E-946A-0541F8D3A1AA"


--Apple-Mail=_F9CA0CF6-37B6-481E-946A-0541F8D3A1AA
Content-Disposition: attachment;
	filename=0001-Capture-build-install-errors-from-subdirs.patch
Content-Type: application/octet-stream;
	name=0001-Capture-build-install-errors-from-subdirs.patch;
	x-unix-mode=0644
Content-Transfer-Encoding: quoted-printable

=46rom=202c67a51c7735b7fa190a5a4e969561638fefe6ae=20Mon=20Sep=2017=20=
00:00:00=202001=0AFrom:=20Enji=20Cooper=20<yaneurabeya@gmail.com>=0A=
Date:=20Wed,=2015=20Feb=202023=2016:03:54=20-0800=0ASubject:=20[PATCH=20=
16/17]=20Capture=20build/install=20errors=20from=20subdirs=0A=0APrior=20=
to=20this=20change=20the=20code=20would=20silently=20fail=20if=20one=20=
of=20the=20subdir=0Abuild/install=20operations=20failed.=20Capture=20all=20=
non-clean=20target=20related=0Afailures=20and=20percolate=20them=20up=20=
the=20stack.=0A=0ASponsored=20by:=20Dell=20EMC=20Isilon=0ASigned-off-by:=20=
Enji=20Cooper=20<yaneurabeya@gmail.com>=0A---=0A=20setup.py=20|=2013=20=
++++++-------=0A=201=20file=20changed,=206=20insertions(+),=207=20=
deletions(-)=0A=0Adiff=20--git=20a/setup.py=20b/setup.py=0Aindex=20=
83dc6b5..4ec5d92=20100755=0A---=20a/setup.py=0A+++=20b/setup.py=0A@@=20=
-2,11=20+2,9=20@@=0A=20=0A=20from=20__future__=20import=20print_function=0A=
=20=0A-from=20distutils.core=20import=20setup=0A-=0A-import=20sys=0A=20=
import=20os=0A-from=20os.path=20import=20join=0A+import=20subprocess=0A=
+import=20sys=0A=20=0A=20DESCRIPTION=20=3D=20"""=0A=20pynfs=0A@@=20=
-19,11=20+17,12=20@@=20DIRS=20=3D=20["xdr",=20"rpc",=20"nfs4.1",=20=
"nfs4.0"]=20#=20Order=20is=20important=0A=20=0A=20def=20setup(*args,=20=
**kwargs):=0A=20=20=20=20=20cwd=20=3D=20os.getcwd()=0A-=20=20=20=20=
command=20=3D=20"=20".join(sys.argv)=0A=20=20=20=20=20for=20dir=20in=20=
DIRS:=0A=20=20=20=20=20=20=20=20=20print("\n\nMoving=20to=20%s"=20%=20=
dir=20)=0A-=20=20=20=20=20=20=20=20os.chdir(join(cwd,=20dir))=0A-=20=20=20=
=20=20=20=20=20os.system("python%s=20%s"=20%=20(sys.version[0],=20=
command))=0A+=20=20=20=20=20=20=20=20os.chdir(os.path.join(cwd,=20dir))=0A=
+=20=20=20=20=20=20=20=20rc=20=3D=20subprocess.call([sys.executable]=20+=20=
sys.argv)=0A+=20=20=20=20=20=20=20=20if=20"clean"=20not=20in=20sys.argv=20=
and=20rc:=0A+=20=20=20=20=20=20=20=20=20=20=20=20sys.exit(rc)=0A=20=20=20=
=20=20os.chdir(cwd)=0A=20=0A=20setup(name=20=3D=20"pynfs",=0A--=20=0A=
2.39.0=0A=0A=

--Apple-Mail=_F9CA0CF6-37B6-481E-946A-0541F8D3A1AA
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii



--Apple-Mail=_F9CA0CF6-37B6-481E-946A-0541F8D3A1AA--

--Apple-Mail=_17331FF5-EC40-4ED4-8388-EF3023FAE58B
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtvtxN6kOllEF3nmX5JFNMZeDGN4FAmPtbZkACgkQ5JFNMZeD
GN4TqA//cvzauMGmvZ9sZ2eSil7vQVpz+WgYUiA3o0pKTrLWRbEDg50X8Lbylu1q
ijW3WadIzSwbBo9Xnf5AxDkAOCf5+IWI7MSnCVVy6NtEDEHnBtlxO5WcAPArITKG
hV0ljC3AY0ewpS5WSMfV6RRQRMNVTxLLhGuKqBI6QEaAc8GZaCLXTYIjbTJmrngq
5WKmtdAmPiysJYDwXq1jJFwQGoCxUNE8zJPP5aV/+NqsaHIgc8Md3Fi2522pNkLb
tszsqoISl1yrwFUJxJFseWX984EhMPaq6xUpiVzsX1kpHJVoY2g7SWbo6Zz7fTwL
2LPL4QNIszxSNU3wd2OtoAHMlNJ90YdnKupaUB0uIchGe2z9GYtNy1/S6VcWozZs
srEIUyaGgqEz+mGeEwZFeItM1tyqHe63IAox4FUZ2vuJLheMMo31cl6kniro2JKp
WSBsnwZ8TaMBurDIN6uDiY1x30RwBMg988c7Lt+TMuKqLUgfJ/N8XfgWgY6bKXFz
kVS/vLi4MW/bLcan3F7s4VJ0ubn6rL4o0Iyf2oIGaL/GsDz+6BFoNOnX6FL4FPIk
OErZH9bpekNUs893mUiGtHZ4mqDBlqdL36xWB1Ga5qQ91M+PHAnR8IV9eNzjciWU
YvdxES9dgv+FXeG3xaC8Xw8/Mt4BdZjxhPzdhmkTxMhfC9r/wFQ=
=tUUR
-----END PGP SIGNATURE-----

--Apple-Mail=_17331FF5-EC40-4ED4-8388-EF3023FAE58B--
