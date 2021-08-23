Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 671063F50F2
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Aug 2021 20:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbhHWTAE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Aug 2021 15:00:04 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:11780 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230245AbhHWTAD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Aug 2021 15:00:03 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17NHIUY9008493;
        Mon, 23 Aug 2021 18:59:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=t27FdBmNv2sRgBQN+lcXHgn43iThCHRG8hFK4Fh0vRc=;
 b=yk3miLTyF5w5/i9EDwQzGbUhOSXGYsnsivVJG6jExsdb0B0lGiZ0GhdPVfhPXJAJAjw1
 esE4WKljeX5bWpkPvxv4rr9hGvn8ZqNGuASujRXiRtfRL4Vmwcxazb5xfm5T22qM5Iv1
 Vc9iL336qTUxJ5whIoqEbFGfa0Ihdd2ZMMoUTQ2891vEB2T1PWUQd1Py6vF4V2Iv/hzB
 G5v99JfIVjlsA0kH5SdcvkijupkbIsI1+NP79Up+XST/gpO3OkEZLV7rwGBgBWjY32HI
 5ARKEB5JxXK4cE6TP9VgDVRLCl0Pf2egslb5tDkNCXWus0ve8V6ON6ikXJyaCs4gdaaP Cw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=t27FdBmNv2sRgBQN+lcXHgn43iThCHRG8hFK4Fh0vRc=;
 b=E1tTBxmVTSbMXcktuDrueInQpRuff/lNvGSw8UhnfErYDWgqSdplVy0NFxI/PEl4j4Jp
 JZpxj6p2d9WaqoV+kG6cOCSHLoVe7jJlm1Xy+UN1m62rFP065apDc5lFCMVenLKyi5U1
 TJxLw9aAec3yoQLVOXNZyJaH3sUYJyJQrNURyNvjQaNYLzddPaIE9a89Bjk/6FhcDexu
 HpxNNeMZzG08GF19WjkoTM1m/+tpbzO2pPygeJQhJn3z+LzkVtqqA72WnfB8E3pFKcPb
 JIyI/sHSlMMRlr1PQW6RPsFVscGvkPABZ4GHK7wAGvqIzDO3ORdM8+NRa1sT/0fIdXVo vg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3akwcfabst-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Aug 2021 18:59:16 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17NIpLpo027133;
        Mon, 23 Aug 2021 18:59:14 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by userp3020.oracle.com with ESMTP id 3akb8t88eh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Aug 2021 18:59:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hixyArWV41gLuhKvr7Pe1sznSBRZvSdR7T6skekkg/2R1YaEIkpI8hzRBUljWNhnmacLhwBX0vQ8YUs+u3IrfaGnPz34J0IBAPbN52UPuAS7nYMUqJTEe4y7X90b8m+AfGldPeIFa8R4+TJq2RTq49/ayRsvRPGOpWPqc9Qee+sFMkqQtlhMmODZgHkGzL/WVBKYhpW01ge1tb78arShbQ8DSbxuXUJNAH2ofA2uwroAmTshIG0v814k4NvFO+drsUNReJIqHlXxoruEQqVuJMovsbVkf5EkHp15sEE6VN0QcVq1mrFufDpEGJwI6OcYbRpqRSiOKmn08HtTA+fjGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t27FdBmNv2sRgBQN+lcXHgn43iThCHRG8hFK4Fh0vRc=;
 b=gDhjL8XsW0jUc3hAyJEC6G1V7uM3fLurr0BeOj7sLKkvtZfhhb//QxuUJ4MBiHtDCF4GxUI2rtHfXqDNNoalmz33Mi0Zb94CHgA/IZFzxSMsqghIQnuGuWyOuo/CoIAb6KSwgU7Ra/PTlFjCuBpztwbZGBrOp1dZo7PQOv0sp6rwKDjOs/GemHRTg+xhbZkDArNfknnSyJCTj3MNcEnIUGLxOZDdnBZzS8M+W4j70n+ZchH6e5xy/M37cPmwA56MkCx1YHVR1YIKhgjBQc6o3qbycYuUmCWWnldLJb2WH8AhSRXDmaH+NeWVpJpCL8FnHOVIRE2AGrblizKBPznm9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t27FdBmNv2sRgBQN+lcXHgn43iThCHRG8hFK4Fh0vRc=;
 b=e7cjCCZKw+3fyRyu6NWlwio8JaSsOboE8jkUhhNmMR9ZNIjmKYX4cdPxAeEItPooTAmIeAfoN5IZBERvVTf3oe9hOUGSX3hGzrmQfw8HvoWJ7TRw/jCqK8/XTXGoy+tZm6RIydbXTmVbRIRjD6R+VGw1p2iAFlBh+j4+s4MBzok=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB5566.namprd10.prod.outlook.com (2603:10b6:a03:3d8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.21; Mon, 23 Aug
 2021 18:59:13 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::a8db:4fc8:ded5:e64]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::a8db:4fc8:ded5:e64%7]) with mapi id 15.20.4436.024; Mon, 23 Aug 2021
 18:59:13 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
CC:     Bruce Fields <bfields@redhat.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <schumakeranna@gmail.com>,
        "daire@dneg.com" <daire@dneg.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 5/8] Keep read and write fds with each nlm_file
Thread-Topic: [PATCH 5/8] Keep read and write fds with each nlm_file
Thread-Index: AQHXlgaoDTPabXQqaUuaOjS+9zbjC6t+J7cAgANNsgCAAAB1AA==
Date:   Mon, 23 Aug 2021 18:59:13 +0000
Message-ID: <D4CAB684-DE35-4964-AB9C-43FD57FA003D@oracle.com>
References: <1629493326-28336-1-git-send-email-bfields@redhat.com>
 <1629493326-28336-6-git-send-email-bfields@redhat.com>
 <FD16AB43-CC95-44FC-AB08-159AF5C3CAB7@oracle.com>
 <20210823185734.GG883@fieldses.org>
In-Reply-To: <20210823185734.GG883@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 22cb5477-8060-42e6-a05c-08d966681902
x-ms-traffictypediagnostic: SJ0PR10MB5566:
x-microsoft-antispam-prvs: <SJ0PR10MB5566753574D0722DE8F949B493C49@SJ0PR10MB5566.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Hy/m3a56qTVc3bwjA47/qkHY76livUQdL66iZV1R7Mu0Qe922oZ4syBMtL8VW+apGYWI09ejOaqCyLBs2JXvdetKyYYk+APPIllnOZZ7cGkjc4hHgmQKbvRTDC++iC8Y/9Y+DEHXp5dzVgO6fhjbu19M3y67WDS1D0X7pmRUXZechLuGxDq8imU8iKMd3ZBDSbEOTraNN5ZmGzMRR+q8SilAusWsVYRbLOg/7m2qrL3Lo0WYSZ9gOJwRamUB5K5ewDLnbQV3YhrfdRMTt2kfm37F51zvxPUFpR0J1ArAy/muip70qrUT7TzsgDCFBM0jUI3HYd3VSOkcFePRkc4FxwAhGHK+W5Dmz0XVGN3XStcE8VXnO0/5K1JLsAKviHO6bm+FOZCcFvKOCg43TOvHhSPELYUhiD5XBVSmM2BUpJKrML5ChV0jQzp1c5qBwW5Z9s68kbvGsUU/xXfn36Se5+evaYaJQ1EwnuNYkM0TB4nw/LGB7x9DLDMRNKaG1ORWCK/tynpeo6FiT2lSpmjKQmSy0EN1Q0HruNzVTL6PDkHQwt4/pp20l81t9TEGC9KX9VQOIwCC9AeKcDfzq0ZE7EhAMy0ggBahnxdggVeQErATRFJ0+Je10VZ+0EZMjig0cL9zT5DiWtezujfuNCRolvahhMJIMdmOhnxhSOj05fcn8c9FIOpvLIyd7Yha2l0Awznx7ux7OJhuOVlVy2gX5gVuWhENusdXy1XAknXRBBe6ds1IAPcMhB2RUqP7uQSl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(2616005)(26005)(5660300002)(4326008)(6916009)(33656002)(86362001)(36756003)(53546011)(6506007)(186003)(54906003)(316002)(83380400001)(508600001)(66946007)(76116006)(91956017)(66446008)(64756008)(66556008)(66476007)(6512007)(71200400001)(38070700005)(6486002)(8676002)(122000001)(38100700002)(8936002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xy6bPp1JzRPqtUvVHjzToMn5+A6NVeHLXjjcbXmvUEbpHMfVlBiB461RIHiw?=
 =?us-ascii?Q?sw1eEjxIUsT5wD4wVx7AlAtueJEvQnTTTadDRbvj7CbZZKD+7hpoAUcx5DbF?=
 =?us-ascii?Q?C5Dm4CMlSfUklbY2l1aMk9qLuLthowYNa2RC9X/wBVE1GsoqIx5Jg4PH6woq?=
 =?us-ascii?Q?nf0fJ3wnHMeoWFiIdAt0kI356oCBY6kspJ3Afj0lHwJL9/frgWGBegM/6Zx6?=
 =?us-ascii?Q?C328ay2iYwdpgoOG7a8YKAEovnI2Irc6YpPpfAToD8OvU66wyyyFThpom+By?=
 =?us-ascii?Q?yjXbMQOngOWTh9OAxriaWf5Z6vKEJEo6G3HSmKcLZcz4Y5aM5BAGh1q1ixlV?=
 =?us-ascii?Q?16xIBuJNxuLpMpWTUqNrlm9tLqpspIwN+ri4CQVTeBMpCQfqWaMHB5SEQltj?=
 =?us-ascii?Q?/RmEsnltvXzE8OVRq20GZ5xsksiKfcJ71DmZnEBI0PGyInokXIpTzZtcskOZ?=
 =?us-ascii?Q?a54DDM83JwYROsbpimGAQ9IjbkcmHnBuEM5D22tMudjebuMMI24KvIiR8dO0?=
 =?us-ascii?Q?XL9GzKyUPFMCuf793gcFoSid2PNNLfNXinclLDoGNZlDTgKXKiGnEeRZBY7b?=
 =?us-ascii?Q?AIHXz1GFv0OmeM6leRoJI/25kf/DSZ48FhovtUm6ePPeA13wCEXVOVLRn1Vr?=
 =?us-ascii?Q?zWIv6FGOVWOx8/Ox3aIGoc6Zz9Dp5dw4orYjm7pWQny/3znGkVsXkX/oNGMH?=
 =?us-ascii?Q?7dXa/DueFE6dxb45r3Cy88xbjbonsCXUUc636G24kDfKS6+CXDtYhbzsWE7w?=
 =?us-ascii?Q?lGXaEv0M7yf/iC0FwoKQ/qLn/3cve8B44n1euaJW2Msapq1jjmiVfkO0XNao?=
 =?us-ascii?Q?ZUJves+e6BqM6gco+3b+jO4HEUcWzhdyUq3MBFVREJYTZo2f7lCS9ZXHNvwg?=
 =?us-ascii?Q?1Jjtt7lcWHipFu3zmbIZlGnUiwH8LYdWLOZ1x/C1xT6SpYnXUZL0cANcHyxU?=
 =?us-ascii?Q?rNjy0zDCvsXTCowXxCGnDw7+R0wfzuVyyyo6lQVazsLs/pCHNuOMo3idc6xu?=
 =?us-ascii?Q?kLJqrKYLCamHjRcFSdlxzb+z0J86GMaAOlMeK1V0a+iaswIYss1SrENMul1O?=
 =?us-ascii?Q?VZwSud/shWB06YlrnzVszFKgZZqVzJP6zC9BSD2IRFoyFD90IFxF0m2c8Dgh?=
 =?us-ascii?Q?ceFxLiW4B+QXTV6J5V459JAc0QGMvccgcrFYT/TUdiGf77Qkp7NyAG8eRGXy?=
 =?us-ascii?Q?XFEP0nLSD8WKwV4RstLqwv+pk8ARlhP2t3+xqB02fTQo3GyEbUVV6tB0yCyV?=
 =?us-ascii?Q?2pe3n9RJW42aOGPEj7Ekigb02hVLnjIYvH71IOzsFrIrCi9gCnXxlSMngCBk?=
 =?us-ascii?Q?dA+Yj2EVIaf2VgMpALWq6LaY?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DE0227989ABB974BB4982FE4823B32FE@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22cb5477-8060-42e6-a05c-08d966681902
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2021 18:59:13.0436
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GOtTtC7il0yJUWdRJ/dE6ehYFgaU16HYW7mBJsFGJz+s8qEqpxMHJi3W3KVw4q9CVzIrvNijzHXdEDpg/LhG7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5566
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10085 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108230129
X-Proofpoint-GUID: 0wuprOuSHLGcuTaJS3NJrrMK6WMpaMSR
X-Proofpoint-ORIG-GUID: 0wuprOuSHLGcuTaJS3NJrrMK6WMpaMSR
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Aug 23, 2021, at 2:57 PM, J. Bruce Fields <bfields@fieldses.org> wrote=
:
>=20
> On Sat, Aug 21, 2021 at 04:30:43PM +0000, Chuck Lever III wrote:
>>> @@ -654,7 +658,12 @@ nlmsvc_unlock(struct net *net, struct nlm_file *fi=
le, struct nlm_lock *lock)
>>> 	nlmsvc_cancel_blocked(net, file, lock);
>>>=20
>>> 	lock->fl.fl_type =3D F_UNLCK;
>>> -	error =3D vfs_lock_file(file->f_file, F_SETLK, &lock->fl, NULL);
>>> +	if (file->f_file[0])
>>> +		error =3D vfs_lock_file(file->f_file[0], F_SETLK,
>>> +					&lock->fl, NULL);
>>> +	if (file->f_file[1])
>>> +		error =3D vfs_lock_file(file->f_file[1], F_SETLK,
>>> +					&lock->fl, NULL);
>>=20
>> Eschew raw integers :-) Should the f_file array be indexed
>> using O_ flags as the comment below suggests?
>=20
> Sure, done.
>=20
>>> diff --git a/fs/lockd/svcsubs.c b/fs/lockd/svcsubs.c
>>> index f43d89e89c45..a0adaee245ae 100644
>>> --- a/fs/lockd/svcsubs.c
>>> +++ b/fs/lockd/svcsubs.c
>>> @@ -71,14 +71,38 @@ static inline unsigned int file_hash(struct nfs_fh =
*f)
>>> 	return tmp & (FILE_NRHASH - 1);
>>> }
>>>=20
>>> +int lock_to_openmode(struct file_lock *lock)
>>> +{
>>> +	if (lock->fl_type =3D=3D F_WRLCK)
>>> +		return O_WRONLY;
>>> +	else
>>> +		return O_RDONLY;
>>=20
>> Style: a ternary would be more consistent with other areas
>> of the code you change in this patch.
>=20
> OK.
>=20
>>> +static int nlm_unlock_files(struct nlm_file *file)
>>> +{
>>> +	struct file_lock lock;
>>> +	struct file *f;
>>> +
>>> +	lock.fl_type  =3D F_UNLCK;
>>> +	lock.fl_start =3D 0;
>>> +	lock.fl_end   =3D OFFSET_MAX;
>>> +	for (f =3D file->f_file[0]; f <=3D file->f_file[1]; f++) {
>>> +		if (f && vfs_lock_file(f, F_SETLK, &lock, NULL) < 0) {
>>> +			printk("lockd: unlock failure in %s:%d\n",
>>> +				__FILE__, __LINE__);
>>=20
>> This needs a KERN_LEVEL and maybe a _once.
>=20
> How about going with pr_warn for now.

Sold.


> I don't *think* there's much
> danger of spamming the logs from this one.  And I'm wondering there
> might be some causes (unresponsive server?) that could resolve
> themselves, and then come back, and that you'd still want to hear about
> the second time.
>=20
>>> @@ -27,7 +27,8 @@ struct rpc_task;
>>> struct nlmsvc_binding {
>>> 	__be32			(*fopen)(struct svc_rqst *,
>>> 						struct nfs_fh *,
>>> -						struct file **);
>>> +						struct file **,
>>> +						int mode);
>>=20
>> Style: "mode_t mode" might be better internal documentation.
>=20
> It's confusing that we use the word "mode" both for "access mode" (O_
> flags) and "mode bits" (permission bits).  This is the former, and I
> thought mode_t was the for the latter.

Fair enough.


>=20
>>> @@ -154,7 +156,8 @@ struct nlm_rqst {
>>> struct nlm_file {
>>> 	struct hlist_node	f_list;		/* linked list */
>>> 	struct nfs_fh		f_handle;	/* NFS file handle */
>>> -	struct file *		f_file;		/* VFS file pointer */
>>> +	struct file *		f_file[2];	/* VFS file pointers,
>>> +						   indexed by O_ flags */
>>=20
>> Right, except that the new code in this patch always indexes
>> f_file with raw integers, making the comment misleading. My
>> preference is to keep the comment and change the new code to
>> index f_file symbolically.
>=20
> OK.
>=20
> --b.

--
Chuck Lever



