Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4674C14CD76
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jan 2020 16:35:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgA2PfX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Wed, 29 Jan 2020 10:35:23 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:32474 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726240AbgA2PfX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 29 Jan 2020 10:35:23 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id uk-mta-6-xUshFdb3PkyTVE3XILwyZw-1;
 Wed, 29 Jan 2020 15:35:19 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 29 Jan 2020 15:35:18 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 29 Jan 2020 15:35:18 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Robert Milkowski' <rmilkowski@gmail.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        'Trond Myklebust' <trondmy@hammerspace.com>
CC:     'Anna Schumaker' <anna.schumaker@netapp.com>,
        'Chuck Lever' <chuck.lever@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        'Trond Myklebust' <trond.myklebust@hammerspace.com>
Subject: RE: [PATCH v4] NFSv4.0: nfs4_do_fsinfo() should not do implicit lease
 renewals
Thread-Topic: [PATCH v4] NFSv4.0: nfs4_do_fsinfo() should not do implicit
 lease renewals
Thread-Index: AdXV6tGXVv4pqJJkS9G0izuAHIy3vAAzr9Pw
Date:   Wed, 29 Jan 2020 15:35:18 +0000
Message-ID: <1d098aa2dfea466a9aaa4c55353221e2@AcuMS.aculab.com>
References: <004e01d5d5ed$5e7ca490$1b75edb0$@gmail.com>
In-Reply-To: <004e01d5d5ed$5e7ca490$1b75edb0$@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: xUshFdb3PkyTVE3XILwyZw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Robert Milkowski
> Sent: 28 January 2020 15:13
> 
> Currently, each time nfs4_do_fsinfo() is called it will do an implicit
> NFS4 lease renewal, which is not compliant with the NFS4 specification.
> This can result in a lease being expired by an NFS server.
...
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index 76d3716..7b2d88b 100644
...
> +	if(status == 0)

Whitespace
	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

