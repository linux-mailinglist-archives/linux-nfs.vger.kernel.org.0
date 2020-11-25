Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 605EA2C35B0
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Nov 2020 01:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbgKYAg1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Nov 2020 19:36:27 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:53952 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727125AbgKYAg1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 24 Nov 2020 19:36:27 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AP0TPXY099526;
        Wed, 25 Nov 2020 00:36:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=PaWkClt1ldyWBCZCPBqERXQQEYT7hXtunXF81hcBg50=;
 b=nsmrWFgV1WKhGgPnnvxyMXPAThYzY7AtUwKRwaogKc69JclUzC6oNYWnXYBUpZrbgJKc
 XIICzmLUUrDmmsz3qpEecWlvDrY3+Aq2hR7I4x/smISEyZ0f3vtP+x6/6A3kmlkBSsdh
 IvORudYkwXE1i/O/62mPakB8RO+URpHsXTFes9lTvVJvZf0ckweB1G34ThJbXKoQmf51
 yOnowdmgAkUPYZf+tSbozWMpSRGXAisAocbvd6yKXxgVK1DlemUm8PdWqcTIDJccsFPL
 uv0pVXfWHRAJ979UcA258z+G4ky1Io7EUdWCrZir5n5EkuiZJUeMr1dhg3JFcvtMHSf+ ng== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 34xtum5h2x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 25 Nov 2020 00:36:23 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AP0Tsoi035405;
        Wed, 25 Nov 2020 00:36:23 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 34ycnt6x28-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Nov 2020 00:36:23 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0AP0aMrs031955;
        Wed, 25 Nov 2020 00:36:22 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 24 Nov 2020 16:36:21 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: NFSD merge candidate for v5.11
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <0cbeed0a0fa2352961966efdd7e62247b5cd7a7b.camel@redhat.com>
Date:   Tue, 24 Nov 2020 19:36:21 -0500
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5A43C026-0746-4F62-8298-2501EF1EF692@oracle.com>
References: <48FA73BE-2D86-4A3F-91D5-C1086E228938@oracle.com>
 <0cbeed0a0fa2352961966efdd7e62247b5cd7a7b.camel@redhat.com>
To:     Jeff Layton <jlayton@redhat.com>, Bruce Fields <bfields@redhat.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9815 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011250001
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9815 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 mlxlogscore=999 impostorscore=0 spamscore=0 mlxscore=0
 phishscore=0 clxscore=1015 suspectscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011250001
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 24, 2020, at 6:14 PM, Jeff Layton <jlayton@redhat.com> wrote:
>=20
> On Tue, 2020-11-24 at 17:51 -0500, Chuck Lever wrote:
>> Hi-
>>=20
>> I've added my NFSv4 XDR decoder series and Bruce's iversion
>> series to my "for next" topic branch to get some early
>> testing exposure for these changes.
>>=20
>> Bruce's series is based on 8/8 posted on November 20, with
>> Jeff's review comments integrated. The NFSD XDR decoder
>> patches are based on v4, posted yesterday afternoon with
>> Bruce's review comments integrated.
>>=20
>> The full branch is available here:
>>=20
>>   git://git.linux-nfs.org/projects/cel/cel-2.6.git cel-next
>>=20
>> or
>>=20
>>   =
http://git.linux-nfs.org/?p=3Dcel/cel-2.6.git;a=3Dshortlog;h=3Drefs/heads/=
cel-next
>>=20
>> ...and is still open for changes or additional patches. This
>> branch is pulled into linux-next regularly.
>=20
> Minor nit in:
>=20
>    =
http://git.linux-nfs.org/?p=3Dcel/cel-2.6.git;a=3Dcommit;h=3D2513716015eba=
398378bf453d5d2dd46c63a3399
>=20
> You added a generic_check_iversion prototype to fs.h.
>=20
> Move that into iversion.h. I think it makes more sense there, and that
> avoids the huge rebuild that occurs when fs.h changes.

Declarations for most other generic_* functions are in fs.h.
But OK, moved, and the series pushed.

So I think the btrfs/ext4/xfs-specific changes might need
sign-off by those maintainers. Should I post this series
to linux-fsdevel? Or, Bruce, do you want to?


--
Chuck Lever



