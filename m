Return-Path: <linux-nfs+bounces-90-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 216927FA467
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Nov 2023 16:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0A9A28150E
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Nov 2023 15:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F26D31A9A;
	Mon, 27 Nov 2023 15:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=epfl.ch header.i=@epfl.ch header.b="AVuZ56fv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp4.epfl.ch (smtp4.epfl.ch [IPv6:2001:620:618:1e0:1:80b2:e059:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B145C3
	for <linux-nfs@vger.kernel.org>; Mon, 27 Nov 2023 07:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=epfl.ch;
      s=epfl; t=1701098896;
      h=From:To:Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
      bh=8yTwxjei4bkS2z96IrWdRO7RT/Z9pnXHisGEjH3m1vs=;
      b=AVuZ56fvfam+kb2YhM8F1tr12ZqMMZkusfQ7TeTiU/6l/ii2b3rPOZAcu1W0521eu
        he6DCSt2SOEOIMpkwxdNzEG4/4eeZH8ILRw9ZV522FiKK9khdYJwCV1/2pqqq8YTe
        nNP814rHL+upzaxkl0XHBt9geE4WsuoqKQbDZEvfE=
Received: (qmail 763 invoked by uid 107); 27 Nov 2023 15:28:16 -0000
Received: from ax-snat-224-159.epfl.ch (HELO EWA02.intranet.epfl.ch) (192.168.224.159) (TLS, AES256-GCM-SHA384 cipher)
  by mail.epfl.ch (AngelmatoPhylax SMTP proxy) with ESMTPS; Mon, 27 Nov 2023 16:28:16 +0100
X-EPFL-Auth: UL8jekqtdm7c1xtfmq+hIS2zpmJqRFgfFChMAgqUG/jVhNML5jM=
Received: from ewa07.intranet.epfl.ch (128.178.224.178) by
 EWA02.intranet.epfl.ch (128.178.224.159) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 27 Nov 2023 16:28:16 +0100
Received: from ewa07.intranet.epfl.ch ([fe80::f470:9b62:7382:7f3a]) by
 ewa07.intranet.epfl.ch ([fe80::f470:9b62:7382:7f3a%4]) with mapi id
 15.01.2507.034; Mon, 27 Nov 2023 16:28:16 +0100
From: Tao Lyu <tao.lyu@epfl.ch>
To: Trond Myklebust <trondmy@hammerspace.com>, "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>
Subject: Re: Question about O_APPEND | O_DIRECT
Thread-Topic: Question about O_APPEND | O_DIRECT
Thread-Index: AQHaHjflhODFfyeMXUSkxSGiPt/2HLCLuRkAgAKTcNA=
Date: Mon, 27 Nov 2023 15:28:16 +0000
Message-ID: <7d2d17e4d3904d29b75fadcfd916b2a3@epfl.ch>
References: <c609e5f9df75438dbfe3810859935d58@epfl.ch>,<2d948b43fa625952e50589e4bedf9551df7ee112.camel@hammerspace.com>
In-Reply-To: <2d948b43fa625952e50589e4bedf9551df7ee112.camel@hammerspace.com>
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

>> Hi,
>>=20
>> Sorry to bother you here.
>>=20
>> I'm using NFS and realize it doesn't support opening a file with
>> "O_DIRECT | O_APPEND".
>>=20
>> After checking the source code,=20
>> I found it has one function that checks explicitly whether there is a
>> combination flag of "O_APPEND | O_DIRECT".
>> If so, it will return invalid arguments.
>>=20
>> int nfs_check_flags(int flags)
>> {
>> =A0=A0=A0 if ((flags & (O_APPEND | O_DIRECT)) =3D=3D (O_APPEND | O_DIREC=
T))
>> =A0=A0=A0=A0=A0=A0=A0 return -EINVAL;
>>=20
>> =A0=A0=A0 return 0;
>> }
>>=20
>> But I don't understand why NFS doesn't support this flag combination.
>> I'd appreciate it if someone could explain this to me.
>
>
> Why do you need O_APPEND|O_DIRECT?
>
> In order to implement O_APPEND|O_DIRECT, we would need to add an APPEND
> operation, which does not exist in the NFS protocol. The WRITE
> operation does not suffice, because it requires you to know the offset
> at which you will be writing the data.

Hi Trond,

Thank you so much for your reply.

O_APPEND | O_DIRECT can be used to bypass the client cache for multiple thr=
eads writing data without caring of the orders (e.g., logs).

Yes, to support O_APPEND | O_DIRECT, NFS must first support APPEND.
But the key point is that looks like NFS has supported O_APPEND already.
I can successfully open a file with "O_RDWR|O_APPEND".

My confusion is why NFS supports O_RDWR and O_APPEND individually but does =
not support this combination.

Thank you in advance for helping me.

Best,
Tao

