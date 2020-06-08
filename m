Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B96E41F1C1D
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jun 2020 17:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730254AbgFHPbC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 8 Jun 2020 11:31:02 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:48146 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729580AbgFHPbB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 8 Jun 2020 11:31:01 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 058FQL7I068196;
        Mon, 8 Jun 2020 15:30:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=94oQWua82dIP6yH5uF3bSIZRKcPk/ur8lPHvIRfdmEU=;
 b=OQCkTBg/PL6Md0IR37WuvAfcDlM7sl4r2F8H6yycKuygAa6yBp9Kn3KGG6A0J9VeYm7c
 V88611eMM4lqsuHQ7X9HX9GHXW+AmF78rIYk5rKq+v1nOCUbiBfM+iv6J9mc2HbuXGha
 QQQs3Eub76P9VnigwSmgpE1w+a/hpAGq8wyRcl8C7B/SNpi5yt6ygn0y/VWaSCnuEZSj
 lhEruOlEd/V3b6PxGBhJo14VH3IbVdnRMchReJudQ/mXejAZu4g3LHUUgtN7C80hbtt/
 OelNXRGPBTxJfRhkqyIYQvLYddhTM1ZVrEPsABgtsrwvT+jJDo/d+wI/OCx9uABej09n hw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 31g3smqe0m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 08 Jun 2020 15:30:55 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 058FRdx2109588;
        Mon, 8 Jun 2020 15:28:55 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 31gn2vcdvf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Jun 2020 15:28:55 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 058FSskF025539;
        Mon, 8 Jun 2020 15:28:54 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 08 Jun 2020 08:28:54 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.14\))
Subject: Re: general protection fault, probably for non-canonical address in
 nfsd
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <9727420.yF10LQ635x@xrated>
Date:   Mon, 8 Jun 2020 11:28:53 -0400
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2B6CBC8C-A1D4-4C39-AF45-958847C99572@oracle.com>
References: <15780697.tcFqIYE18H@xrated>
 <11558085.O9o76ZdvQC@linux-ws1.messinet.com> <9727420.yF10LQ635x@xrated>
To:     Hans-Peter Jansen <hpj@urpla.net>,
        Anthony Joseph Messina <amessina@messinet.com>
X-Mailer: Apple Mail (2.3445.104.14)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9645 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006080114
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9645 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 cotscore=-2147483648 suspectscore=0
 spamscore=0 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006080114
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jun 7, 2020, at 1:44 PM, Hans-Peter Jansen <hpj@urpla.net> wrote:
>=20
> Am Sonntag, 7. Juni 2020, 18:01:55 CEST schrieb Anthony Joseph =
Messina:
>> On Sunday, June 7, 2020 10:32:44 AM CDT Hans-Peter Jansen wrote:
>>> Hi,
>>>=20
>>> after upgrading the kernel from 5.6.11 to 5.6.14, we suffer from =
regular
>>> crashes of nfsd here:
>>>=20
>>> 2020-06-07T01:32:43.600306+02:00 server rpc.mountd[2664]: =
authenticated
>>> mount request from 192.168.3.16:303 for /work (/work)
>>> 2020-06-07T01:32:43.602594+02:00 server rpc.mountd[2664]: =
authenticated
>>> mount request from 192.168.3.16:304 for /work/vmware (/work)
>>> 2020-06-07T01:32:43.602971+02:00 server rpc.mountd[2664]: =
authenticated
>>> mount request from 192.168.3.16:305 for /work/vSphere (/work)
>>> 2020-06-07T01:32:43.606276+02:00 server kernel: [51901.089211] =
general
>>> protection fault, probably for non-canonical address =
0xb9159d506ba40000:
>>> 0000 [#1] SMP PTI 2020-06-07T01:32:43.606284+02:00 server kernel:
>>> [51901.089226] CPU: 1 PID: 3190 Comm: nfsd Tainted: G           O
>>> 5.6.14-lp151.2-default #1 openSUSE Tumbleweed (unreleased)
>>> 2020-06-07T01:32:43.606286+02:00 server kernel: [51901.089234] =
Hardware
>>> name: System manufacturer System Product Name/P7F-E, BIOS 0906
>>=20
>> I see similar issues in Fedora kernels 5.6.14 through 5.6.16
>> https://bugzilla.redhat.com/show_bug.cgi?id=3D1839287
>>=20
>> On the client I mount /home with sec=3Dkrb5p, and /mnt/koji with =
sec=3Dkrb5
>=20
> Thanks for confirmation.=20
>=20
> Apart from the hassle with server reboots, this issue has some DOS =
potential,=20
> I'm afraid.

If you have a reproducer (even a partial one) then bisecting between a
known good kernel and v5.6.14 (or 16) would be helpful.


--
Chuck Lever



