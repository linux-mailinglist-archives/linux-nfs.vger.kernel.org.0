Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7FE429AD37
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Oct 2020 14:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2900633AbgJ0NZA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 27 Oct 2020 09:25:00 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37082 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2900629AbgJ0NY7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 27 Oct 2020 09:24:59 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09RDOVoT033003;
        Tue, 27 Oct 2020 13:24:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=fC+yZrdMxx7rSRuu0HJMNlV82nWZ5C8M4zX+YqUM4ho=;
 b=VoeRpNvxOEn3W9L3HnlWZuR+LzS5QRUIsdzjPfpAi44qShrs3bHiOlQqlw+zUsKHZ6ZU
 O9IzWHDFm5p/Eov9MmGVAHX8Y2s7FrVNYaoiGMxSoRfnAvulLY+ImjFBcb2WoQkog7vW
 RNzTJhY86W+grYnOMXqZmulk6VpRbZHcMWeVEq/ba6x8yKOZOspH9Y6kiZSF2M1hIKbS
 db74btrBbxlE1ac0diDm/njRd699QRUuUze7aOXHkV8ztNU8SyjaDmQvkg0uIu3upYWR
 sDk3UV8YCJBdyCmjvGHHYOGMrPR2aM8c0KsbPaOLNTrMw3d5oewH9kg7cpAVnm2eDa1e KA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 34dgm3yg52-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 27 Oct 2020 13:24:56 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09RDLJlG126554;
        Tue, 27 Oct 2020 13:24:56 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 34cx6vy4ur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Oct 2020 13:24:56 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09RDOtaa005149;
        Tue, 27 Oct 2020 13:24:55 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 27 Oct 2020 06:24:55 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH 00/20] NFSD support for multiple RPC/RDMA chunks
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20201027060823.GF4821@unreal>
Date:   Tue, 27 Oct 2020 09:24:54 -0400
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-rdma@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <DAC657D8-D254-452C-9B21-3053F70C8C73@oracle.com>
References: <160373843299.1886.12604782813896379719.stgit@klimt.1015granger.net>
 <20201027060823.GF4821@unreal>
To:     Leon Romanovsky <leon@kernel.org>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9786 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010270084
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9786 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 bulkscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 suspectscore=0 clxscore=1015 mlxscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010270084
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Leon-

> On Oct 27, 2020, at 2:08 AM, Leon Romanovsky <leon@kernel.org> wrote:
>=20
> On Mon, Oct 26, 2020 at 02:53:53PM -0400, Chuck Lever wrote:
>> This series implements support for multiple RPC/RDMA chunks per RPC
>> transaction. This is one of the few remaining generalities that the
>> Linux NFS/RDMA server implementation lacks.
>>=20
>> There is currently one known NFS/RDMA client implementation that can
>> send multiple chunks per RPC, and that is Solaris. Multiple chunks
>> are rare enough that the Linux NFS/RDMA implementation has been
>> successful without this support for many years.
>=20
> So why do we need it? Solaris is dead, and like you wrote Linux =
systems
> work without this feature just fine, what are the benefits? Who will =
use it?

The Linux NFS implementation is living. We can add the ability
to provision multiple chunks per RPC to the Linux NFS client at
any time.

Likewise any actively developed NFS/RDMA implementation can add
this feature. The RPC/RDMA version 1 protocol does not have the
ability to communicate the maximum number of chunks the server
will accept per RPC.

Other server implementations do support multiple chunks per RPC.
The Linux NFS/RDMA server implementation has always been incomplete
in this regard.

And the Linux NFS server implementation (the non-transport specific
part) already supports multiple data payloads per NFSv4 COMPOUND.


Restoring a little more of the cover letter:

>> Along with multiple chunk support, this series adds the following
>> benefits:
>>=20
>> - More robust input sanitization of RPC/RDMA headers
>> - An internal representation of chunks that is agnostic to their
>>  wire format

The Linux NFS/RDMA server implementation does need to have better
input sanitization.

And there is a version 2 of RPC/RDMA under active development:

https://datatracker.ietf.org/doc/draft-ietf-nfsv4-rpcrdma-version-two/

Having some protocol version agnosticism in our transport might
be necessary eventually.

--
Chuck Lever



