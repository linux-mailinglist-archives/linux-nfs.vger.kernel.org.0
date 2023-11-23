Return-Path: <linux-nfs+bounces-39-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBE27F661B
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Nov 2023 19:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 787F81C20C85
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Nov 2023 18:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4F54B5C8;
	Thu, 23 Nov 2023 18:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=epfl.ch header.i=@epfl.ch header.b="doe7THtQ"
X-Original-To: linux-nfs@vger.kernel.org
X-Greylist: delayed 398 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 23 Nov 2023 10:21:36 PST
Received: from smtp0.epfl.ch (smtp0.epfl.ch [IPv6:2001:620:618:1e0:1:80b2:e058:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B596F9
	for <linux-nfs@vger.kernel.org>; Thu, 23 Nov 2023 10:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=epfl.ch;
      s=epfl; t=1700763294;
      h=From:To:Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
      bh=LKE7a7WUe5YoK/V5zT/ELU27eBfC14QgGED0o0vh5iw=;
      b=doe7THtQIUJ7bgQ3mfiQjwseRN+hFiIRY0w8W865v4rN1UDVoBNYUWufhYojR/jTn
        SXZlHy+Srh6NtvYyI7PJP5LjOLl64mgf7sWWMclIFVPbaEisbRKIWV98V4PEeOGq5
        5C8uQ+zJ3nAf/ilhKEkDBhXkXVfP4GOCsxdwPX9e8=
Received: (qmail 2029 invoked by uid 107); 23 Nov 2023 18:14:54 -0000
Received: from ax-snat-224-177.epfl.ch (HELO ewa06.intranet.epfl.ch) (192.168.224.177) (TLS, ECDHE-RSA-AES256-GCM-SHA384 (P-256 curve) cipher)
  by mail.epfl.ch (AngelmatoPhylax SMTP proxy) with ESMTPS; Thu, 23 Nov 2023 19:14:54 +0100
X-EPFL-Auth: rOfTDiA50tYiPU4849FIMcDLqLac6pRoBE0IZhcfKia8Nd0e6T0=
Received: from ewa07.intranet.epfl.ch (128.178.224.178) by
 ewa06.intranet.epfl.ch (128.178.224.177) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 23 Nov 2023 19:14:51 +0100
Received: from ewa07.intranet.epfl.ch ([fe80::f470:9b62:7382:7f3a]) by
 ewa07.intranet.epfl.ch ([fe80::f470:9b62:7382:7f3a%4]) with mapi id
 15.01.2507.034; Thu, 23 Nov 2023 19:14:51 +0100
From: Tao Lyu <tao.lyu@epfl.ch>
To: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Question about O_APPEND | O_DIRECT
Thread-Topic: Question about O_APPEND | O_DIRECT
Thread-Index: AQHaHjflhODFfyeMXUSkxSGiPt/2HA==
Date: Thu, 23 Nov 2023 18:14:51 +0000
Message-ID: <c609e5f9df75438dbfe3810859935d58@epfl.ch>
Accept-Language: en-US, fr-CH
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

Sorry to bother you here.

I'm using NFS and realize it doesn't support opening a file with "O_DIRECT =
| O_APPEND".

After checking the source code,=20
I found it has one function that checks explicitly whether there is a combi=
nation flag of "O_APPEND | O_DIRECT".
If so, it will return invalid arguments.

int nfs_check_flags(int flags)
{
=A0=A0=A0 if ((flags & (O_APPEND | O_DIRECT)) =3D=3D (O_APPEND | O_DIRECT))
=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;

=A0=A0=A0 return 0;
}

But I don't understand why NFS doesn't support this flag combination.
I'd appreciate it if someone could explain this to me.

Thanks in advance.

Best,
Tao



