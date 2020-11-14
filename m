Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 374EE2B2FAF
	for <lists+linux-nfs@lfdr.de>; Sat, 14 Nov 2020 19:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbgKNS05 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 14 Nov 2020 13:26:57 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:35084 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbgKNS04 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 14 Nov 2020 13:26:56 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AEIEHSH123729;
        Sat, 14 Nov 2020 18:26:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=34EL6e1uL1LV1NTcE/3nyhOeRFTDI95Houe1u4t94s8=;
 b=ixZnfT3DRhU6Gvv7Y0Eh5RPGp/MXUd0IW7Sha5MSAmfu07ge2YIrdR/591FpKGss0mGc
 s/iKEybzslZ33HMihsoK3jPxbmmkWJOMVKuFZfKy69nE+MJsrPESc5dwAIKpav/9ClPL
 ckZgzLNCUFPT5Ur0RMHABr8Sfb3HtwTD6IuYM6fCL599Wxoced0ioaSQLlS2WePEY1f2
 YslkTj+kl6ZKvJUMrqSY5LVwuOC+ILmKOC7W8mmfSFFdHTCfU3OX0f0QxXImi+ZlCmM3
 GpZYPWEZMCbF0k6cCIqmmKxNsZUYWJDRN7rAHSVj4uysRC4UlnAAb9+JIXRWStJF0Lf2 ag== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 34t4rah9dt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 14 Nov 2020 18:26:48 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AEIGO8E037149;
        Sat, 14 Nov 2020 18:26:47 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 34t4bt23fw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 14 Nov 2020 18:26:47 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0AEIQiML026518;
        Sat, 14 Nov 2020 18:26:44 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 14 Nov 2020 10:26:44 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH v1 06/61] NFSD: Replace READ* macros in
 nfsd4_decode_access()
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20201114092846.GA29362@infradead.org>
Date:   Sat, 14 Nov 2020 13:26:43 -0500
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E38DF8DB-D9C8-4139-AB5F-5905FCFB44E5@oracle.com>
References: <160527962905.6186.17550620763636619885.stgit@klimt.1015granger.net>
 <160527977531.6186.18215866313473241680.stgit@klimt.1015granger.net>
 <20201114092846.GA29362@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9805 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011140124
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9805 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011140124
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 14, 2020, at 4:28 AM, Christoph Hellwig <hch@infradead.org> =
wrote:
>=20
>> +static __be32
>> +nfsd4_decode_access(struct nfsd4_compoundargs *argp, struct =
nfsd4_access *access)
>=20
> Please fix up a bunch of overly long lines here and in the other
> patches.

Not saying no, but...

Kernel coding style and scripts/checkpatch.pl were recently
updated to permit 100 character long lines. What reason is
there to shorten these?

--
Chuck Lever



