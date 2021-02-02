Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46CC130CEB9
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Feb 2021 23:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232294AbhBBWWs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 2 Feb 2021 17:22:48 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:40224 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235063AbhBBWWL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 2 Feb 2021 17:22:11 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 112MF9Zs165542;
        Tue, 2 Feb 2021 22:21:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=4JN2io+U+YTEHNHINY5nkrzgcIKM6Hc2Fkxd0OWgMRE=;
 b=UkiHMJO9b7Dnsuc7TIERK73TkTisntDin/HZvkbC7EFQpU1Xm9z/mqtgrVyhn59jATta
 tmt4h/ReXS25jyPHtjq347OfV1sXf6YlOzHDtH1TgBdUucOvRLObg9hleX/JBIRFI5eD
 qqWXPPw4FS3+Gjc4Msf3mxLQ7uh1JoTA5d/PrWOv713A0c2EbNS3s/cdhgZmyDXBD/rS
 Zl1tZwg/6MUoQ7Xm+D6szMoiB9tavDSuVE3ZLZCp5XL27UfLfte4ThO0MZWpQf0AWlNY
 vk9P1Lx2eqUYv70quqCCoU7Y1Pwj+ETI72cJaVOTsLcM51PO3N+c2MrIOhW67cJRmzNR cw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 36cvyawbm3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Feb 2021 22:21:21 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 112MAxbx037541;
        Tue, 2 Feb 2021 22:21:21 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by aserp3020.oracle.com with ESMTP id 36dhbyxwkf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Feb 2021 22:21:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ebpFOMD6EAJttJjd/geNzlAFkEc+nuXUF2cjWkqdfdQkyHAGFcFnWPfz91MyACawf8bUm26m5AaJ7Ad9e7LqcjgFmVmRldiiAhxc2V1hJG1TbRa09rhHCDfph59/5IBt8rGb66RBiGyptcAL+Jn1wvz0Rc0BLJS25k179P1CZiqiXauZrNAVbl85W2HAD7IxZDY46c7egH0LrT3LZZcM9eDYYVm1KpfWXgU9Db4ngiXbD4+G7Sbhqp52i1ASDlUU1yfQDpJD96noDV0cpaJzm+hEqERuI8kgsm081M70/to+/DDFtFVb6QornN2w/CPMlRvd9i/JRiJQAJxwwhP4iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4JN2io+U+YTEHNHINY5nkrzgcIKM6Hc2Fkxd0OWgMRE=;
 b=CQXvUlfQeoCduUQYJbkbThBBYuEAwXK2CcXvnpQtAq2IeSlSDqpWGTmPam+8Hmxa5S9CRRlOt+SygK2GxKNVdOo9mRBVN+VMnulR+m/RyiahZOD6VgGkDWEsuSkuLe1BIG+NqKTvKxnDC8rDnjHZB/SvOMqWspLKhZ7X6HvGOxPOslvaL6sY9sWYs50cg9vuOydypOJyJKZDkxcQ2hwRhbzUeDXRjgoTfJV3zpHcL2fii26hWXzJ6jvJSTSkdViK6KGUrPmuNmueN1ZVdIwP00RqvI5+y3R0BGEwn3//dn89Z9XFuBYzTV8+mOSHSzZKltg8pk8j9xkVgQZcx7f8WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4JN2io+U+YTEHNHINY5nkrzgcIKM6Hc2Fkxd0OWgMRE=;
 b=UIDLx2++Heu61Z8Dvpi6rLdyGwDlMa7jgTW8cG2Xe78xwvOvMlcJt4XvZH+hAOetAo2FcyJCn4onPR48z7n2ksDb4YyM/hpsRnmb2LEPKa8NDzy2wFT4S9RUP36MX7QD9w+JeUQY42SxXQFDaFzIgZT7gPEQ8x11xjmQhZn9Rl0=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3462.namprd10.prod.outlook.com (2603:10b6:a03:121::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.19; Tue, 2 Feb
 2021 22:21:19 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3805.027; Tue, 2 Feb 2021
 22:21:19 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     "dan@kernelim.com" <dan@kernelim.com>,
        "bcodding@redhat.com" <bcodding@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Anna Schumaker <schumaker.anna@gmail.com>
Subject: Re: [PATCH v2 0/5] SUNRPC: Create sysfs files for changing IP
Thread-Topic: [PATCH v2 0/5] SUNRPC: Create sysfs files for changing IP
Thread-Index: AQHW+ZPDkI44uVsPcUiYIRmrZ1p/T6pFNZQAgAAASgCAAAj5gIAABxUAgAApaYCAAAD3AA==
Date:   Tue, 2 Feb 2021 22:21:19 +0000
Message-ID: <102D99DF-30C7-4360-9A84-D5A4DA77FE1C@oracle.com>
References: <20210202184244.288898-1-Anna.Schumaker@Netapp.com>
 <75F3F315-84AA-41A0-A43A-C531042A9C47@oracle.com>
 <CAFX2JfktYGe4vDtXogFHurdyz4TJx5APj9pb-J5HmsDGC99kaA@mail.gmail.com>
 <20210202192417.ug32gmuc2uciik54@gmail.com>
 <8A686173-B3FF-4122-990C-6E8795D35161@redhat.com>
 <7dfd7e3b9fb39da71f1654347ca2f2feba4fc04d.camel@hammerspace.com>
In-Reply-To: <7dfd7e3b9fb39da71f1654347ca2f2feba4fc04d.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: hammerspace.com; dkim=none (message not signed)
 header.d=none;hammerspace.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c39bb532-c08e-417e-64d3-08d8c7c8dd6b
x-ms-traffictypediagnostic: BYAPR10MB3462:
x-microsoft-antispam-prvs: <BYAPR10MB34622F9B9672432DD32D9A2C93B59@BYAPR10MB3462.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1i8Br3dIMdlnao1SAjCtGKXWghAZ6uc/XIaGj229rCvsIUlpVhO4xEffmtAOzLGdcmoOCM2Q1ZhtzUFlK/REF3VF1JgWJFxxdXDR0wVm8lxWeLDiB9JlYtnkN7zrgJvGeFmih2JREvYK0tE+JHmb2u4+2RmugRa5USLQ0Gb+f2mrd/w6fGXBLUsfN9uczQJ4c9GNdu/ZV6pgfTZ7kJQncs8sgDcAtkj18z90lBhVkumq6b9mGMY8UaY7y1weLiy121KhfzcYmZUKvs3SRJt3lKNUy2ZzUBRUWtLryGSO09U4e9cuKAo5vL7wIUfTHs/ligdmu+qRJ8ns2Ana5SUbprTQ6y2kb2VxKiQBon4B32UQot6zlQLY9OJNNZiEc9Aqr1FkNUcHdkKpOaWpaNr1G4L/Yi82XznTGWyclTZ0r/KyYcHXo6Kc3xLhxyXOmDp4/56PLhfmgzeLa/eaWXAkKd3Q7a5vSscbqOps84IwCrQgLkk+B9OtyPdiD2ZVZms1zWLuBEpkGMgq78w/IEDDCQgMyQP3ORFTQqd78YVOrUS+O+QEgmwf7d0teMNn9Me1DDq2O7QrlaBdXA2qZT9yYw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(376002)(366004)(396003)(346002)(5660300002)(6486002)(6512007)(478600001)(8676002)(66946007)(91956017)(2616005)(4326008)(2906002)(66556008)(64756008)(71200400001)(8936002)(76116006)(66476007)(53546011)(6506007)(86362001)(186003)(26005)(6916009)(33656002)(316002)(44832011)(54906003)(36756003)(66446008)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?S5CM9app7WGhLkj0haekwNej2HgU3Q+jzLOfJI6FWWS1j3UjpkzdkscDXyJG?=
 =?us-ascii?Q?ietgD3lNag+1/sc5dJuX4HCKNrW6hvE2RVqqAN3Los1IRJLw1TT0NePAX+ZF?=
 =?us-ascii?Q?KSAP1TIuQ7ND2lm38B3sWKJ7ID7/zN+Vm4ttZoY6v/yS3SttUtrhxreFO4vp?=
 =?us-ascii?Q?qqnqPWBrxX+WeZ7CZft6mc9Js04iD32rMNm9ecsGvvoiPiwsWvwStA4SLPlw?=
 =?us-ascii?Q?Zn8WET0eEYUGRw/huJ9+3MOHfJHgwbfIzWLW4yoTvaipSHj6rWnvtwm1aie/?=
 =?us-ascii?Q?6EsGg67QYK7CaMV8qq1otknhLIvKKIafxVdy0oaReEPoItfhkKCs1xt7JRU3?=
 =?us-ascii?Q?cA5A2bvtRbevCKb3mhp1oThmnRVbmJdkJRC0y5zgdzJKkVsaVMiD9QbH8jpD?=
 =?us-ascii?Q?pWpKyT0K14AqOYtXj39fmBqjXOnPUCohdh1VQDu3DrB2jfO/H0zgKuMroTfj?=
 =?us-ascii?Q?JhmrUTiRntdhGZZi5E0HEXuUw+054jUKtyucb17CZD2mw6BLgodPnDQsJ0z7?=
 =?us-ascii?Q?g0MFZ6oNqX/Y7sRK+7nXlDMnBZoYXC70McMQR0PQHJgkxSbaElbIvSUWC1Zk?=
 =?us-ascii?Q?2Lh//UpyY8MH5HuWhfqgatBHil8r3Wn0I5MPnNcdyKNvZ0SyVN+QDovFuD7P?=
 =?us-ascii?Q?6bFE3iVbM/XLb8x3/TSAtUWs4wwS7LgSbivEwzc9VEorK4stJoGTsc/XEJUd?=
 =?us-ascii?Q?OuiH2g84GByn5ihpnGVlBX4VAVKSdG4rHSM/lUT3fMyFaxYIb8OyKgJVeNOj?=
 =?us-ascii?Q?0eKaFpyiYlMRF6VOv88hr7B9GDUB6ZZeOviaSY7YuQvtw3EBimPcAwZfrc++?=
 =?us-ascii?Q?TTIL/8AfduZVbrPyU9zZhsQc7GWRs6Ck7sWCWdSZ84PvBOKYcBH3tyMHRSGl?=
 =?us-ascii?Q?alxDz8MHcCl5LIaHrgBdVfdhEvnyFB60WnlbvY1H1YViRShE3tVR7aF6l5ks?=
 =?us-ascii?Q?GAcNfL+ktpYJQO9c9IIOdH3spUZiPO3I0VwTSJ2rHyRhuowcAF79dRlz2NsR?=
 =?us-ascii?Q?4oKGPbck5x25udR5Y7Ca7EPgX7J2xpAb/pE+LbVrJdMKX9tH+yt6hJg9CTIm?=
 =?us-ascii?Q?CyWSeozdT7zsXdokYOFa+T4Lpe9+iQ=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C904FD9E5C0FA24D94C6C44EB5A2008D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c39bb532-c08e-417e-64d3-08d8c7c8dd6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2021 22:21:19.4238
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BhVJHJGLJFRWTnWzcH/zR58PDIeoLjSw70WK4XVzToFNkYhpJhcfuDRwL6L+fidZk6ZI56gChpuxBQ+iijjdaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3462
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9883 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 spamscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102020141
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9883 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 impostorscore=0
 mlxscore=0 spamscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102020141
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Feb 2, 2021, at 5:17 PM, Trond Myklebust <trondmy@hammerspace.com> wro=
te:
>=20
> On Tue, 2021-02-02 at 14:49 -0500, Benjamin Coddington wrote:
>> On 2 Feb 2021, at 14:24, Dan Aloni wrote:
>>=20
>>> On Tue, Feb 02, 2021 at 01:52:10PM -0500, Anna Schumaker wrote:
>>>> You're welcome! I'll try to remember to CC him on future versions
>>>> On Tue, Feb 2, 2021 at 1:51 PM Chuck Lever
>>>> <chuck.lever@oracle.com> wrote:
>>>>>=20
>>>>> I want to ensure Dan is aware of this work. Thanks for posting,
>>>>> Anna!
>>>=20
>>> Thanks Anna and Chuck. I'm accessing and monitoring the mailing
>>> list via
>>> NNTP and I'm also on #linux-nfs for chatting (da-x).
>>>=20
>>> I see srcaddr was already discussed, so the patches I'm planning to
>>> send
>>> next will be based on the latest version of your patchset and
>>> concern
>>> multipath.
>>>=20
>>> What I'm going for is the following:
>>>=20
>>> - Expose transports that are reachable from xprtmultipath. Each in
>>> its
>>>   own sub-directory, with an interface and status representation
>>> similar
>>>   to the top directory.
>>> - A way to add/remove transports.
>>> - Inspiration for coding this is various other things in the kernel
>>> that
>>>   use configfs, perhaps it can be used here too.
>>>=20
>>> Also, what do you think would be a straightforward way for a
>>> userspace
>>> program to find what sunrpc client id serves a mountpoint? If we
>>> add an
>>> ioctl for the mountdir AFAIK it would be the first one that the NFS
>>> client supports, so I wonder if there's a better interface that can
>>> work
>>> for that.
>>=20
>> I'm a fan of adding an ioctl interface for userspace, but I think
>> we'd
>> better avoid using NFS itself because it would be nice to someday
>> implement
>> an NFS "shutdown" for non-responsive servers, but sending any ioctl
>> to the
>> mountpoint could revalidate it, and we'd hang on the GETATTR.
>>=20
>> Maybe we can figure out a way to expose the superblock via sysfs for
>> each
>> mount.
>=20
> Right. There is potential functionality here that we do not need or
> even want to expose via the mount interface. Being able to cancel all
> the hung RPC calls in an RPC queue, for instance, is not something you
> want to do through fsopen() and friends.

I thought we were talking only about an ioctl or fsopen cmd that
identifies the transports that are associated with an NFS mount.

Ostensibly a read-only use of that API.


--
Chuck Lever



