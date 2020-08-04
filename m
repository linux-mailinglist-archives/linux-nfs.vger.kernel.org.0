Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18D0023BAE7
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Aug 2020 15:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbgHDNND (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 4 Aug 2020 09:13:03 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:35820 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727987AbgHDNND (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 4 Aug 2020 09:13:03 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 074D7D0e101393;
        Tue, 4 Aug 2020 13:13:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=hJiDTxwJQvETbzxifQe3+lqFwhRNuuUsrAkVqvUv+n0=;
 b=fE3TtfV+IL/u47Y6BsmWVHoLb6/0xHp5vJog3rl7YejUPRQoCxrv0kumuhufye3cZYmE
 tXKAUmstWD9PJ2jGorDYAxdFGwRKTC3cmRQSjsa1GoyhkrMCEhfJ4UiPMcugwVKuRGQl
 oL+8JHxQCe46owbirtXGDxgmSctHyymGkZF+CYen5y7mCTPkwlIm/h1NL6Wzk4zrjWp2
 tKrLaKL4c8iTwcWxYWwRlOQs799Tfh65tUqK6IWBChUsKaJ0oUf0zUX5ammVigM7CkHT
 iaylLEzn7rQFmCOW2r3AjcGrjN9axSIKRTTpXjFa9OW5tz/DarCdpKfmmiu0FGAJDkwC pA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 32pdnq7frp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 04 Aug 2020 13:12:59 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 074DCvgf056282;
        Tue, 4 Aug 2020 13:12:59 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 32pdhc10r5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Aug 2020 13:12:59 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 074DCu1t000429;
        Tue, 4 Aug 2020 13:12:56 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 04 Aug 2020 06:12:56 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: NFS over RDMA issues on Linux 5.4
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <d41ac40e-8974-0a44-2b9f-bede74619935@rothenpieler.org>
Date:   Tue, 4 Aug 2020 09:12:55 -0400
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F6BDB1B6-6315-47C9-A589-F4A57E25B2C5@oracle.com>
References: <8a1087d3-9add-dfe1-da0c-edab74fcca51@rothenpieler.org>
 <CE6C02CE-3EEB-4834-B499-376BC6020A17@oracle.com>
 <20200804093635.GA4432@unreal>
 <92a5a932-b843-eed3-555e-7557ccc1f308@rothenpieler.org>
 <20200804122557.GB4432@unreal>
 <DAF6EFDA-5863-4887-B495-0BE3CA714209@oracle.com>
 <d41ac40e-8974-0a44-2b9f-bede74619935@rothenpieler.org>
To:     Timo Rothenpieler <timo@rothenpieler.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9702 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008040098
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9702 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 adultscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008040097
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Aug 4, 2020, at 9:08 AM, Timo Rothenpieler <timo@rothenpieler.org> =
wrote:
>=20
> On 04.08.2020 14:49, Chuck Lever wrote:
>> Timo, I tend to think this is not a configuration issue.
>> Do you know of a known working kernel?
>=20
> This is a brand new system, it's never been running with any kernel =
older than 5.4, and downgrading it to 4.19 or something else while in =
operation is unfortunately not easily possible. For a client it would =
definitely not be out of the question, but the main nfs server I cannot =
easily downgrade.
>=20
> Also keep in mind that the dmesg spam happens on both server and =
client simultaneously.

Let's start with the client only, since restarting it seems to clear the =
problem.


> I'll see if I can borrow two of the nodes to turn into a temporary =
test system for this.
>=20
> The Kernel for this system is self-built and not any distribution =
kernel.

Would it be easy to try a kernel earlier in the 5.4.y stable series?


> This could not be a missing kernel config option or something?

Doubtful.


--
Chuck Lever



