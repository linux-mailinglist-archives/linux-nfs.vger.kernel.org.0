Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 057EA2C1271
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 18:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388521AbgKWR40 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 12:56:26 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:43882 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388320AbgKWR40 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 12:56:26 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0ANHifKh064887;
        Mon, 23 Nov 2020 17:56:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=8quk0PtO1aBVnXz7oiPe5b4Ix+xEXgDxuzR8RZevIEw=;
 b=KmQznC5jhqYC4TIp8BA7uqw5gkFhH4QoI5GghZi4wmL8C55y7wyqHUy3x+FbV7Zgb2Tl
 Ebh9YQO0nOL1U/R1vcnq/v0GRFBxq18esMt+HDR8St84RDYYrtqvwDOIRojmeV5i2BPK
 8fLmr2nM+AQuXl1O5a0UD1L1FZXF40cKCkaWlpIkMAklNWmZ/jo0jBj+D1RnprpEKchu
 TNA3F2RT5BSpHq/Ay1qqWrGR8CAhDbDP1chI48VNQOVl5+R1Cd9xEoaQYMkye58Wm2Jk
 bdB/H/HcB0+0N64uYgSven53IzQj5eLAuO2ilWoAF67Y/KVig75/sFz0lj821K3sv1N9 WQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 34xrdapptf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 23 Nov 2020 17:56:15 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0ANHetmw095260;
        Mon, 23 Nov 2020 17:56:14 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 34yctv6v06-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Nov 2020 17:56:14 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0ANHuDTs001307;
        Mon, 23 Nov 2020 17:56:13 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 23 Nov 2020 09:56:13 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH 1/1] NFSv4.2: fix LISTXATTR buffer receive size
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20201123173802.GA26158@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
Date:   Mon, 23 Nov 2020 12:56:11 -0500
Cc:     Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F8B0C391-9230-4B30-BCCD-D5E7EECF4910@oracle.com>
References: <20201113190851.7817-1-olga.kornievskaia@gmail.com>
 <99874775-A18C-4832-A2F0-F2152BE5CE32@oracle.com>
 <CAN-5tyEyQbmc-oefF+-PdtdcS7GJ9zmJk71Dk8EED0upcorqaA@mail.gmail.com>
 <07AF9A5C-BC42-4F66-A153-19A410D312E1@oracle.com>
 <CAN-5tyFpeVf0y67tJqvbqZmNMRzyvdj_33g9nJUNWW62Tx+thg@mail.gmail.com>
 <7E0CD3F3-84F2-4D08-8D5A-37AA0FA4852D@oracle.com>
 <20201119232647.GA11369@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
 <CAN-5tyH+ZCiqxKQEE9iGURP-71Xd2BqzHuWWPMzZURePKXirfQ@mail.gmail.com>
 <CAN-5tyEJ4Lbf=Ht2P4gwd9y4EPvN=G6teAiaunL=Ayxox8MSdg@mail.gmail.com>
 <20201123173802.GA26158@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
To:     Frank van der Linden <fllinden@amazon.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9814 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 spamscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011230118
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9814 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 impostorscore=0 mlxscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011230118
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 23, 2020, at 12:38 PM, Frank van der Linden =
<fllinden@amazon.com> wrote:
>=20
> On Mon, Nov 23, 2020 at 11:42:46AM -0500, Olga Kornievskaia wrote:
>> Hi Frank, Chuck,
>>=20
>> I would like your option on how LISTXATTR is supposed to work over
>> RDMA. Here's my current understanding of why the listxattr is not
>> working over the RDMA.
>>=20
>> This happens when the listxattr is called with a very small buffer
>> size which RDMA wants to send an inline request. I really dont
>> understand why, Chuck, you are not seeing any problems with hardware
>> as far as I can tell it would have the same problem because the =
inline
>> threshold size would still make this size inline.
>> rcprdma_inline_fixup() is trying to write to pages that don't exist.
>>=20
>> When LISTXATTR sets this flag XDRBUF_SPARSE_PAGES there is code that
>> will allocate pages in xs_alloc_sparse_pages() but this is ONLY for
>> TCP. RDMA doesn't have anything like that.
>>=20
>> Question: Should there be code added to RDMA that will do something
>> similar when it sees that flag set? Or, should LISTXATTR be =
re-written
>> to be like READDIR which allocates pages before calling the code.
>=20
> Hm.. so if the flag never worked for RDMA, was NFS_V3_ACL ever tested
> over RDMA? That's the only other user.
>=20
> If the flag simply doesn't work, I agree that it should either be =
fixed
> or just removed.
>=20
> It wouldn't be the end of the world to change LISTXATTRS (and =
GETXATTR)
> to use preallocated pages. But, I didn't do that because I didn't want =
to
> waste the max size (64k) every time, even though you usually just get
> a few hundred bytes at most. So it seems like fixing =
XDRBUF_SPARSE_PAGES
> is cleaner.

Also, because this is for a receive buffer, the transport always has
to allocate the maximum number of pages. Especially for RPC/RDMA, this
is not an "allocate on demand" kind of thing. The maximum buffer size
has to be allocated every time.

--
Chuck Lever



