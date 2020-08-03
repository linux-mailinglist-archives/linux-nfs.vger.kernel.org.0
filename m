Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F22F23AA68
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Aug 2020 18:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgHCQYd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Aug 2020 12:24:33 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:56008 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726624AbgHCQYb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 3 Aug 2020 12:24:31 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 073GLuUD040454;
        Mon, 3 Aug 2020 16:24:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=Sj7HVhacoxnmHEpoaOlRqZUx5bPbdDtLYndSotkkDWI=;
 b=Uv0M+EBPNEV7yrVflMBYnR/HWhGvUr68kNqzOPG5+BUbXSuDNbUXG+z8wAvodeIaE/SJ
 MXRCwoVSCuC6Fb/jeiAD3OtuuEEoM+yI572mOdcUDTYyJEv4mzEDdcoNNeR0MLKPMa7i
 iKcK61gzjs1Fak8IGrs6cN5/b45PlGq6b2Mt4mrKbufggBmyJN8Xe2X6QVPFDziOvgig
 WPYUtYCkrnskEmVTKlIpwzJJYVj5HJ6897BWltu0gbi+X/ami3vUVZRzUJLc9OxEyr50
 uMOVVxG+Uch/aJVFbMQ/CoyaD+y38ipzFJ82FSROUiosQhsaytWw6bc5zp8SXsIlo8NT Gg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 32nc9ye1vg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 03 Aug 2020 16:24:24 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 073GN7gY019082;
        Mon, 3 Aug 2020 16:24:24 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 32p5gqyrys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Aug 2020 16:24:24 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 073GONkh019394;
        Mon, 3 Aug 2020 16:24:23 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 03 Aug 2020 09:24:23 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: NFS over RDMA issues on Linux 5.4
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <8a1087d3-9add-dfe1-da0c-edab74fcca51@rothenpieler.org>
Date:   Mon, 3 Aug 2020 12:24:21 -0400
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <CE6C02CE-3EEB-4834-B499-376BC6020A17@oracle.com>
References: <8a1087d3-9add-dfe1-da0c-edab74fcca51@rothenpieler.org>
To:     Timo Rothenpieler <timo@rothenpieler.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9702 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 phishscore=0 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008030119
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9702 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxscore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 adultscore=0 clxscore=1011 malwarescore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008030119
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Timo-

> On Aug 3, 2020, at 11:05 AM, Timo Rothenpieler <timo@rothenpieler.org> =
wrote:
>=20
> Hello,
>=20
> I have just deployed a new system with Mellanox ConnectX-4 VPI EDR IB =
cards and wanted to setup NFS over RDMA on it.
>=20
> However, while mounting the FS over RDMA works fine, actually using it =
results in the following messages absolutely hammering dmesg on both =
client and server:
>=20
>> =
https://gist.github.com/BtbN/9582e597b6581f552fa15982b0285b80#file-server-=
log
>=20
> The spam only stops once I forcibly reboot the client. The filesystem =
gets nowhere during all this. The retrans counter in nfsstat just keeps =
going up, nothing actually gets done.
>=20
> This is on Linux 5.4.54, using nfs-utils 2.4.3.
> The mlx5 driver had enhanced-mode disabled in order to enable IPoIB =
connected mode with an MTU of 65520.
>=20
> Normal NFS 4.2 over tcp works perfectly fine on this setup, it's only =
when I mount via rdma that things go wrong.
>=20
> Is this an issue on my end, or did I run into a bug somewhere here?
> Any pointers, patches and solutions to test are welcome.

I haven't seen that failure mode here, so best I can recommend is
keep investigating. I've copied linux-rdma in case they have any
advice.

--
Chuck Lever



