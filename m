Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD214BE58
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2019 18:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725843AbfFSQfj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 19 Jun 2019 12:35:39 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:45526 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfFSQfi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 19 Jun 2019 12:35:38 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5JGYGVB138915;
        Wed, 19 Jun 2019 16:35:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=VF1VRXW69CGRr/GyvubhOqgjUiKRm5oU08IgtZPoulU=;
 b=qL1RexAsIKBkklYkUP2nwbhg3187H13hNxEYBIHmsXk97g0790/KwpkazbY7a+r9oj++
 rAz9Dp03Abs5bRwqnDM6/zhSBS7R3K5goUH2c3BE9Jz5/Phsv7om9R5tt9wgHnvRHL/2
 /ugtQHK0led4birYe62GDo8aBCqdfzwwR77vwTz0ItrJ2YbKFR4yJwluYWq2untd3mpk
 hyXd5OzPYYGnVhTGtLZ38HMFZuuerrwrSEvEHIvvmT4RlZyLjO6m4Z4ehQT6+u+sBPp8
 CUPMq/ef8sqc1w3DlCeE+nZFCrg9pqTfJe4RgcSUKXgl0AXCQ9wpJmbT2fSw2D6gEeu9 MQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2t7809cjeq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jun 2019 16:35:04 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5JGXBPp021766;
        Wed, 19 Jun 2019 16:35:04 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2t77yn6ux7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jun 2019 16:35:04 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5JGZ3Jg032084;
        Wed, 19 Jun 2019 16:35:03 GMT
Received: from anon-dhcp-171.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 19 Jun 2019 09:35:02 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 3/3] mountstats: Check for RPC iostats version >= 1.1 with
 error counts
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20190613120314.1864-3-dwysocha@redhat.com>
Date:   Wed, 19 Jun 2019 12:35:00 -0400
Cc:     Steve Dickson <SteveD@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <FD291454-53BB-46DB-BEBE-9AA2F8DE18DE@oracle.com>
References: <20190612190229.31811-1-dwysocha@redhat.com>
 <20190613120314.1864-1-dwysocha@redhat.com>
 <20190613120314.1864-3-dwysocha@redhat.com>
To:     Dave Wysochanski <dwysocha@redhat.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9293 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906190133
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9293 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906190134
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jun 13, 2019, at 8:03 AM, Dave Wysochanski <dwysocha@redhat.com> =
wrote:
>=20
> Add explicit check for statsvers instead of array based check.

Hi Dave,

I don't understand why this change is necessary. The patch description
should explain.



> Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
> ---
> tools/mountstats/mountstats.py | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tools/mountstats/mountstats.py =
b/tools/mountstats/mountstats.py
> index 5f13bf8e..2ebbf945 100755
> --- a/tools/mountstats/mountstats.py
> +++ b/tools/mountstats/mountstats.py
> @@ -476,7 +476,7 @@ class DeviceData:
>                 if retrans !=3D 0:
>                     print('\t%d retrans (%d%%)' % (retrans, ((retrans =
* 100) / count)), end=3D' ')
>                     print('\t%d major timeouts' % stats[3], end=3D'')
> -                if len(stats) >=3D 10 and stats[9] !=3D 0:
> +                if self.__rpc_data['statsvers'] >=3D 1.1 and stats[9] =
!=3D 0:
>                     print('\t%d errors (%d%%)' % (stats[9], ((stats[9] =
* 100) / count)))
>                 else:
>                     print('')
> --=20
> 2.20.1
>=20

--
Chuck Lever



