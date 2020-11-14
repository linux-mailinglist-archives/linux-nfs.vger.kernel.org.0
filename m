Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2C2B2B2FD0
	for <lists+linux-nfs@lfdr.de>; Sat, 14 Nov 2020 19:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgKNSsT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 14 Nov 2020 13:48:19 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:49340 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbgKNSsS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 14 Nov 2020 13:48:18 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AEIZWkR167016;
        Sat, 14 Nov 2020 18:48:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=NBXqk/VrP+lexiOZXN4jxe6/Os6V41bi4HZAE6+KkFM=;
 b=l895mMUSpizuFB4i9GhF6q70yauOm0tdFSvXV4ESFT8A5Uyk+k7hHa4quVeRcygd7PRr
 H+NUBxNq/1+8885k6VJzvgcaKlbepqX15oYeW6tbQAkLD9jNQ4Qz/BFflAWHJZn+apGy
 n424fFCDhkSgUvg0saEveriEbD/ov++Iw39QJQtns3yIiCrAmiDwATQZ9BE3ErjN7F2p
 +hSW6ADaGBoFegoqtZn7VmKnRsQ/KYr3MLhaVAjG+MzyWXISkAnT3MzTB8liM5vmI17H
 pGxbY2LtSCSUf/TAwS2DQEoFOjeKWkDMd3XElfFo6vjyHNHCFSZZ7bNTu9ljXzGJ3duu Nw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 34t4rah9yf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 14 Nov 2020 18:48:14 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AEIZ7rZ007600;
        Sat, 14 Nov 2020 18:48:14 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 34t7203t2r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 14 Nov 2020 18:48:14 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0AEImEfW003705;
        Sat, 14 Nov 2020 18:48:14 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 14 Nov 2020 10:48:13 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH v1 06/61] NFSD: Replace READ* macros in
 nfsd4_decode_access()
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20201114184516.GA12185@infradead.org>
Date:   Sat, 14 Nov 2020 13:48:13 -0500
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <573FCC0F-9F4E-4378-9839-799DA15AA9B6@oracle.com>
References: <160527962905.6186.17550620763636619885.stgit@klimt.1015granger.net>
 <160527977531.6186.18215866313473241680.stgit@klimt.1015granger.net>
 <20201114092846.GA29362@infradead.org>
 <E38DF8DB-D9C8-4139-AB5F-5905FCFB44E5@oracle.com>
 <20201114184516.GA12185@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9805 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 suspectscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011140125
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9805 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011140125
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 14, 2020, at 1:45 PM, Christoph Hellwig <hch@infradead.org> =
wrote:
>=20
> On Sat, Nov 14, 2020 at 01:26:43PM -0500, Chuck Lever wrote:
>>=20
>>=20
>>> On Nov 14, 2020, at 4:28 AM, Christoph Hellwig <hch@infradead.org> =
wrote:
>>>=20
>>>> +static __be32
>>>> +nfsd4_decode_access(struct nfsd4_compoundargs *argp, struct =
nfsd4_access *access)
>>>=20
>>> Please fix up a bunch of overly long lines here and in the other
>>> patches.
>>=20
>> Not saying no, but...
>>=20
>> Kernel coding style and scripts/checkpatch.pl were recently
>> updated to permit 100 character long lines. What reason is
>> there to shorten these?
>=20
> The coding style only allows it as an exception if it significantly
> improves readabily.  and modern checkpatch.pl unfortunately is wrong
> more often than not.

So you would prefer:

static __be32 nfsd4_decode_access(struct nfsd4_compoundargs *argp,
                                  struct nfsd4_access *access)

?

--
Chuck Lever



