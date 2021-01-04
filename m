Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAE152E9C7D
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Jan 2021 19:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725889AbhADSBg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 4 Jan 2021 13:01:36 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:56298 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbhADSBg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 4 Jan 2021 13:01:36 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 104HwqUv036743;
        Mon, 4 Jan 2021 18:00:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=A6cMvxW5UU8+tjwwHq1ACaZSaeaVbnEMQXhDp06xYpQ=;
 b=OEK6S8inzv/SzfQ+OkHWyCjgDqJ1agdsVHp/IQy77pkfsaUvQVuDBayOrdUoKUKOX2RJ
 sjhrAMdLyjBwqkHWqTTTr7bQLL459Szo2fI0eaXMAE8d2IJeaocH7PJDtk0yOT2Te0/V
 RlrgQLiOr/xClmV6JVLu3LvKalmPq5ttHNf7+LVpj7Cv8h8Uphy2z5D/qBjnkp6HwPxd
 ncRWZBNjsaapEIz+P9VLMfV2AIlRlboqh7V+lpIhG4790tbVqcxLRqCRikskHUOQJBRs
 DFzxuIpHrAwhQjJbpEYGI2ygXO5L5kvR69FzsLf7AQuETI/gWfywvMCnYxNGgyzQBJ6V fw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 35tgsknfeb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 04 Jan 2021 18:00:54 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 104HwZqT142215;
        Mon, 4 Jan 2021 18:00:53 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 35v2axgh5e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Jan 2021 18:00:53 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 104I0qNW026487;
        Mon, 4 Jan 2021 18:00:52 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 Jan 2021 10:00:52 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: Boot time improvement with systemd and nfs-utils
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAL5u83FRV_-sae4cXLN3VqFe_=3wXm5g911LFjzohCp+c+55aQ@mail.gmail.com>
Date:   Mon, 4 Jan 2021 13:00:51 -0500
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A5C09F1B-9309-40AC-99E6-BADA5CAD6CED@oracle.com>
References: <CAL5u83HS=nurJ=r0tJU8ZqAXXkvu9-vWZpbVWoKALNh22WdKnw@mail.gmail.com>
 <87F51982-465A-46D4-BFB9-4B5E5A7EB82C@oracle.com>
 <CAL5u83FRJQ_ys32S1KWjx72kamNw_3a2eFEAwH=MNMhruU9X=g@mail.gmail.com>
 <6F313888-0355-4286-8692-E4685BCB2536@oracle.com>
 <CAL5u83Fxd2rGuYuaghcC4irUtscmXr5-p36Qqf4+FwtctZJFaQ@mail.gmail.com>
 <07383012-D499-498E-A194-716ABE1DE4C2@oracle.com>
 <CAL5u83FRV_-sae4cXLN3VqFe_=3wXm5g911LFjzohCp+c+55aQ@mail.gmail.com>
To:     Hackintosh Five <hackintoshfive@gmail.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9854 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 malwarescore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101040117
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9854 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 malwarescore=0
 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101040118
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I'm not aware of a similar reason why the notify step would need to
block the boot process. Maybe Type=3Dforking is wrong, but I thought
sm-notify was a forking/daemonizing type of utility.


> On Jan 4, 2021, at 11:03 AM, Hackintosh Five =
<hackintoshfive@gmail.com> wrote:
>=20
> I see. Does rpc-statd-notify HAVE to start before nfs-client? If not,
> perhaps a one-off timer unit with no delay could be made so that the
> startup of rpc-statd-notify doesn't block the boot process, while
> still running after network-online?
>=20
> On Mon, Jan 4, 2021 at 1:26 PM Chuck Lever <chuck.lever@oracle.com> =
wrote:
>>=20
>> The problem is not in sm-notify itself, it's in the C library =
functions. The system's DNS resolver configuration is set during network =
startup. When a process first attempts a DNS query, it retrieves the =
system DNS configuration as it is at that moment, and keeps that =
configuration until the process exits. If sm-notify starts before the =
system's DNS resolver is configured, then it simply doesn't work because =
it can't perform DNS queries correctly.


--
Chuck Lever



