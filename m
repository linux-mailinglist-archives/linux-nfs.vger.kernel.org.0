Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8D223BD83
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Aug 2020 17:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgHDPst (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 4 Aug 2020 11:48:49 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:32838 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbgHDPsr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 4 Aug 2020 11:48:47 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 074FlMd0007927;
        Tue, 4 Aug 2020 15:48:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=sVUQs9JX3NSyjoikJ5LSbRAP7R3pbBP3jH00fg9ChBw=;
 b=FwQCyLdd1PVdfxqAQc3oDMIhSr86FeZ3Geem4R7HWE/fquKoWfyQAqJwTRXYmjGfHqCH
 gSxfa3DYjhZ+GUqBmASqiKm1dR9S3AfVGPGQkabCkRT3UweUHIRx905OFdX2r6Szhgd+
 xfVycQExLy+fF4y5VFhzRmK/c2R1F0w60GuFPXuxj8O6iC69zlimE0FKHi3LSiDRtWTP
 /xQRbPIlsZp5P8vd9ePyxkacNYHeJH6ZuLEtfeQs4yDl9zOA8j6A117lJcPLZ28fSW1u
 QV2IYt0FDJfVhldHctGCyfvLStnN7Zazc/5eqSht0vsmLUJjj7nDIvvSf4Z4iWsmoOYg 7A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 32pdnq8duf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 04 Aug 2020 15:48:43 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 074Fgq8a170060;
        Tue, 4 Aug 2020 15:46:42 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 32pdnqjf80-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Aug 2020 15:46:42 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 074FkgvJ002670;
        Tue, 4 Aug 2020 15:46:42 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 04 Aug 2020 08:46:41 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: NFS over RDMA issues on Linux 5.4
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <7c7418cb-7f7a-5de3-2025-7bde5cd5ac2a@rothenpieler.org>
Date:   Tue, 4 Aug 2020 11:46:41 -0400
Cc:     Leon Romanovsky <leon@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4751E7F5-AAB1-4602-B926-9BB08E1D213D@oracle.com>
References: <8a1087d3-9add-dfe1-da0c-edab74fcca51@rothenpieler.org>
 <CE6C02CE-3EEB-4834-B499-376BC6020A17@oracle.com>
 <20200804093635.GA4432@unreal>
 <92a5a932-b843-eed3-555e-7557ccc1f308@rothenpieler.org>
 <20200804122557.GB4432@unreal>
 <DAF6EFDA-5863-4887-B495-0BE3CA714209@oracle.com>
 <d41ac40e-8974-0a44-2b9f-bede74619935@rothenpieler.org>
 <F6BDB1B6-6315-47C9-A589-F4A57E25B2C5@oracle.com>
 <20200804134642.GC4432@unreal>
 <45BA86D8-52A3-407E-83BE-27343C0182C5@oracle.com>
 <B82C41F6-1C23-44F5-B802-621F6B63E12F@oracle.com>
 <7c7418cb-7f7a-5de3-2025-7bde5cd5ac2a@rothenpieler.org>
To:     Timo Rothenpieler <timo@rothenpieler.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9703 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 mlxscore=0
 bulkscore=0 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008040118
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9703 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 adultscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008040118
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Aug 4, 2020, at 11:39 AM, Timo Rothenpieler <timo@rothenpieler.org> =
wrote:
>=20
> On 04.08.2020 17:34, Chuck Lever wrote:
>> I see a LOC_LEN_ERR on a Receive. Leon, doesn't that mean the =
server's
>> Send was too large?
>> Timo, what filesystem are you sharing on your NFS server? The thing =
that
>> comes to mind is https://bugzilla.kernel.org/show_bug.cgi?id=3D198053
>=20
> The filesystem on the server is indeed a zfs-on-linux (version 0.8.4), =
just as in that bug report.
>=20
> Should I try to apply the proposed fix you posted on that bug report =
on the client (and server?).

If you are hitting that bug, the server is the problem. The client
should work fine once the server is fixed. (I'm not happy about
the client's looping behavior either, but that will go away once
the server behaves).

I'm not hopeful that the fix applies cleanly to v4.19, but it
might. Another option would be upgrading your NFS server.


--
Chuck Lever



