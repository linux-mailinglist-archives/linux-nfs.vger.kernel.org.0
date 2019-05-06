Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B310B154C2
	for <lists+linux-nfs@lfdr.de>; Mon,  6 May 2019 22:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbfEFUCO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 May 2019 16:02:14 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:39222 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbfEFUCO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 6 May 2019 16:02:14 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x46Jhru1156451;
        Mon, 6 May 2019 20:02:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=qOHfcohDi+TD15VR5v0vllwydFTvWhTCAjbK5XXAGWw=;
 b=CX2rLGcTzipwjVUcz+b6kNQxWAIEOTJPpE1X2uYwDQD9RS3+cenMOMHXjYzKwrYflq6o
 7FwKwbVH5E47sjPVGfm5EoU8cDsHvKEMOEyGeXz+dPHf+J7cM6Cc7LNWVal0GVIRNSTZ
 ox7McNYuFqZB5noEskpps0nOgZ3WqUs9BQsjzgeKdUgh/bgg5tmO2jrEu7SYlM/SNEwY
 wU7d2XNBIP/HKcLKjz+/ForqkotcuhH0BDTfQjijUpFPDVg0Ay+7P7lASLDAn65onths
 5ZzttllsX5M4oQdyg2qPxIr2+LSQQRsOIl5PKzCL7JxAreiGsl2igDL7WynASTofArUj zw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2s94b0gwuq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 May 2019 20:02:10 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x46K10r3195222;
        Mon, 6 May 2019 20:02:09 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2s9ayeg5k6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 May 2019 20:02:09 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x46K240J018209;
        Mon, 6 May 2019 20:02:08 GMT
Received: from anon-dhcp-171.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 06 May 2019 13:02:04 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [RFC PATCH 0/5] bh-safe lock removal for SUNRPC
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <6d1e56b4b352ee29eb8c88f95e4b839117562e42.camel@hammerspace.com>
Date:   Mon, 6 May 2019 16:02:01 -0400
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E24BA50E-21DF-4642-8922-B47F69CC42BD@oracle.com>
References: <20190503111841.4391-1-trond.myklebust@hammerspace.com>
 <39608ABA-9E3F-443A-9F4C-7B91B885C7DD@oracle.com>
 <6d1e56b4b352ee29eb8c88f95e4b839117562e42.camel@hammerspace.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
X-Mailer: Apple Mail (2.3445.104.8)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9249 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905060162
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9249 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905060162
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On May 6, 2019, at 2:37 PM, Trond Myklebust <trondmy@hammerspace.com> =
wrote:
>=20
> On Mon, 2019-05-06 at 14:22 -0400, Chuck Lever wrote:
>> Hi Trond-
>>=20
>>> On May 3, 2019, at 7:18 AM, Trond Myklebust <trondmy@gmail.com>
>>> wrote:
>>>=20
>>> This patchset aims to remove the bh-safe locks on the client side.
>>> At this time it should be seen as a toy/strawman effort in order to
>>> help the community figure out whether or not there are setups out
>>> there that are actually seeing performance bottlenecks resulting
>>> from taking bh-safe locks inside other spinlocks.
>>=20
>> What kernel does this patch set apply to? I've tried both v5.0 and
>> v5.1, but there appear to be some changes that I'm missing. The
>> first patch does not apply cleanly.
>>=20
>=20
> It should hopefully apply on top of Anna's linux-next branch.

OK, you did mention that to me last week. Sorry for the noise.

--
Chuck Lever



