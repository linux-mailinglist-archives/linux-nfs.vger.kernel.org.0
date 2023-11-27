Return-Path: <linux-nfs+bounces-100-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE857FA6AD
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Nov 2023 17:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E44CB2102A
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Nov 2023 16:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07F32EB13;
	Mon, 27 Nov 2023 16:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=epfl.ch header.i=@epfl.ch header.b="jiOJaPli"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp4.epfl.ch (smtp4.epfl.ch [IPv6:2001:620:618:1e0:1:80b2:e059:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F8A198
	for <linux-nfs@vger.kernel.org>; Mon, 27 Nov 2023 08:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=epfl.ch;
      s=epfl; t=1701103281;
      h=From:To:CC:Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
      bh=2Y6dpandy6vfM5kCmpfb0IzyeUGaqbJ4zJEyjefgrM4=;
      b=jiOJaPliSv+DfjhGNr1dAxfNVgKxpI2uf9ikjQkx7JfmSlQ7fO36XndZ6A4p1kmyF
        y5V4+qTNknPj4xBxWfVf77XkxwN7mpEBp1cFvIxFLOnes52hT7Oezx3anc51sADna
        i4D82hKkgLuL6bDn5kQmQcyoFdJW4kO2gSutRnDXo=
Received: (qmail 29391 invoked by uid 107); 27 Nov 2023 16:41:21 -0000
Received: from ax-snat-224-159.epfl.ch (HELO EWA02.intranet.epfl.ch) (192.168.224.159) (TLS, AES256-GCM-SHA384 cipher)
  by mail.epfl.ch (AngelmatoPhylax SMTP proxy) with ESMTPS; Mon, 27 Nov 2023 17:41:21 +0100
X-EPFL-Auth: R8hvf+eXsV0sXicJRoFmzoBHxX0ZDu4BDc9ssRY33bVAuP++DXA=
Received: from ewa07.intranet.epfl.ch (128.178.224.178) by
 EWA02.intranet.epfl.ch (128.178.224.159) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 27 Nov 2023 17:41:18 +0100
Received: from ewa07.intranet.epfl.ch ([fe80::f470:9b62:7382:7f3a]) by
 ewa07.intranet.epfl.ch ([fe80::f470:9b62:7382:7f3a%4]) with mapi id
 15.01.2507.034; Mon, 27 Nov 2023 17:41:18 +0100
From: Tao Lyu <tao.lyu@epfl.ch>
To: Christoph Hellwig <hch@infradead.org>
CC: Trond Myklebust <trondmy@hammerspace.com>, "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>
Subject: Re: Question about O_APPEND | O_DIRECT
Thread-Topic: Question about O_APPEND | O_DIRECT
Thread-Index: AQHaHjflhODFfyeMXUSkxSGiPt/2HLCLuRkAgAKTcNCAAAYXgIAAEVQV
Date: Mon, 27 Nov 2023 16:41:17 +0000
Message-ID: <b8bfb3af4e844ea3b980ad3c378c2e8b@epfl.ch>
References: <c609e5f9df75438dbfe3810859935d58@epfl.ch>
 <2d948b43fa625952e50589e4bedf9551df7ee112.camel@hammerspace.com>
 <7d2d17e4d3904d29b75fadcfd916b2a3@epfl.ch>,<ZWTFn0/FtJ5WuQGc@infradead.org>
In-Reply-To: <ZWTFn0/FtJ5WuQGc@infradead.org>
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

> On Mon, Nov 27, 2023 at 03:28:16PM +0000, Tao Lyu wrote:
>>=20
>> O_APPEND | O_DIRECT can be used to bypass the client cache for multiple =
threads writing data without caring of the orders (e.g., logs).
>>=20
>> Yes, to support O_APPEND | O_DIRECT, NFS must first support APPEND.
>> But the key point is that looks like NFS has supported O_APPEND already.
>> I can successfully open a file with "O_RDWR|O_APPEND".
>>=20
>> My confusion is why NFS supports O_RDWR and O_APPEND individually but do=
es not support this combination.

> Well, it does support O_RDWR|O_APPEND, just not with O_DIRECT?

Hi Christoph,=20

Yes, it just doesn't work with O_DIRECT.

> Btw, I think an APPEND operation in NFS would be a very good idea, and
> I'd love to work with interested parties in the IETF on it.=A0 Not that
> we (Damien to be specific) plan to add support to Linux to also report
> the actual offset an O_APPEND write wrote to through io_uring as we
> have varios use cases for out of place write data stores for that.
> It would be great to also support that programming model over NFS.=

