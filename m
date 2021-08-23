Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 716803F5321
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Aug 2021 00:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232931AbhHWWBn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Aug 2021 18:01:43 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:23818 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232898AbhHWWBm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Aug 2021 18:01:42 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17NLZf2H016644;
        Mon, 23 Aug 2021 22:00:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=noo+RLrMKG7X5BtvqRBoL7/7IFKTgXwX23UA99N0qlk=;
 b=eT2MOWRzk9ZrEf/WQs3i5xPcuW5SYjFwvCB4kf46B+LR6FS4dxJmyHjf/whFKp16+HmE
 XIOQI1wlAVQm5IviVpICa26EVrPJaaXZjBZ5sXMzU925fcbXcJZnnvhMB/iDvGNwiqQd
 WqPqqKTirpFx+TUNGyUsgmgx4bCjjsdNNrITg0/xrs0hrYiwUoLVgtBFPQqBI+UVJ8dQ
 qgsqlZGtQ+XVjoON5O8BcWSB1euzjo06RkuC3ZOFSKwIh0eRpYF8Szkt2+5amIzEeHuE
 HUUIUMGcvu+RbqU3Kwa8WgFEPOPsL3XrUM8ThoAAvIMeAZmmNjRNsCWZaiJiTeYzPMjX 5w== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=noo+RLrMKG7X5BtvqRBoL7/7IFKTgXwX23UA99N0qlk=;
 b=lvi2Ju9CKWlNiZ8pLu8JBeJVqANV22jf/xgdxWAW3tid2BrikrTy9LKTYOxRhduEd5PR
 R8Ll+PLCVSZ+37TXG4pkpEvBHy1P+jhIGgQeYrATOGPXaZDz0u/Z8MwTCf4fnRgMYoxS
 PgrDPLL4zKXWaXuzHNXSSQQYckm3wzwP7nR3PaDRfqo1FCklVVLIhRrdZrqdSrbMDbHe
 zBq1iJfoEewxj+rY6GN6siCBgqGL2P0k5lBfJyBTkIagsznu6upc2oc2DoOKz+eFiOOh
 FjnEDxSL8EiVVK9fQb4IQIRC72HZvKH8N2hr8b93LCnP57/94OgsNbwbHJqDYgPXMjRn Tg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3aktrttvv4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Aug 2021 22:00:50 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17NLpBgf010966;
        Mon, 23 Aug 2021 22:00:49 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by aserp3020.oracle.com with ESMTP id 3ajsa43f9f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Aug 2021 22:00:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HNbIhdEvZvM0VQKVQslFqN2S6QHpogkKT+x2jfP/5Vp9EPziI4Lt/x9OR63oo7EKXKmn7cQUdAvYJNTJEIlQYrmbvSEtfFRzHfY6CJzp3J78Jtm3ZWXzg6w9ZZAx8vbj1BfTjr6GnurI0qEIZSEsNhY2/D6QAnNKhBI2W0IUEI8BkcXx6pXOiUQ+KxnB/yjCpvc5M9vs1iWotcBdsISvDxZs5tJ1bjf5P9Y5A9BEwe8XOFF4vi/B3Aj677peGlUWstNwrNsIzJCt8f54megzmKJDdXTey9wcFcqjvhZcG7h1FQ6y7u512qz6CSv0NKKMcWrjuKeVAQcuTqemHNpDkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=noo+RLrMKG7X5BtvqRBoL7/7IFKTgXwX23UA99N0qlk=;
 b=KfKyLZoxCpAWg1oFjn4L7L/HYXG/yAXts78hbdwmRnCoLcQrPeh4Sk0WH5O2xaUF+s3JaTA5Sv2FbmQbsfqwdqAWCOrSCYTP95xzQ4THNyFLREpZ9D0gGAPqnXDTdG5oLpwt+kpegzcRPdtyimG0jry0rYsoC07EQ1l6+MoGjyFnjV6c9pxNpGFHIDRSgD3DUBqj204E9eRwB6iEFwjlvak0K3jHjTGuZhkc27+ecVk2gtmWfuDklSZKxB9tppgnnAQTJpGTcj6w6Edtqt/UZ5jr8NYTftuMFRjg+cj9NCiNziFb2v3FDlEh8Flrv3u1Y6zSfEG/6RikG4Oi1FSj2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=noo+RLrMKG7X5BtvqRBoL7/7IFKTgXwX23UA99N0qlk=;
 b=EGJNsH7QKpAiZ0jo8o863wUm2GTyQlU6geL5GLRYz2bVR8Is1WpvQqVg3WP5r5O433rXfsOJ6fCMwbiguosxg3UF7JEGUJjOtlx/GEK7zrZCN6I1lkerYNAk1cZl/vcYggvI2MT1858tNFraOPeuZj5gQSdS5xeQSFKCq7kiAvs=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB2646.namprd10.prod.outlook.com (2603:10b6:a02:aa::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.24; Mon, 23 Aug
 2021 22:00:47 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::a8db:4fc8:ded5:e64]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::a8db:4fc8:ded5:e64%7]) with mapi id 15.20.4436.024; Mon, 23 Aug 2021
 22:00:47 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
CC:     Bruce Fields <bfields@redhat.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <schumakeranna@gmail.com>,
        "daire@dneg.com" <daire@dneg.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 5/8] Keep read and write fds with each nlm_file
Thread-Topic: [PATCH 5/8] Keep read and write fds with each nlm_file
Thread-Index: AQHXlgaoDTPabXQqaUuaOjS+9zbjC6t+J7cAgANNsgCAAAB1AIAAHUgAgAATpYCAAAE8AIAAAJIA
Date:   Mon, 23 Aug 2021 22:00:47 +0000
Message-ID: <1FFC48D3-F69F-4187-B8FB-3B67EC73757F@oracle.com>
References: <1629493326-28336-1-git-send-email-bfields@redhat.com>
 <1629493326-28336-6-git-send-email-bfields@redhat.com>
 <FD16AB43-CC95-44FC-AB08-159AF5C3CAB7@oracle.com>
 <20210823185734.GG883@fieldses.org>
 <D4CAB684-DE35-4964-AB9C-43FD57FA003D@oracle.com>
 <20210823204400.GH883@fieldses.org>
 <B4927FC9-0B91-48FC-84B4-3F56CB03747A@oracle.com>
 <20210823215844.GA10881@fieldses.org>
In-Reply-To: <20210823215844.GA10881@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1ac97f49-96e1-410a-2d90-08d966817684
x-ms-traffictypediagnostic: BYAPR10MB2646:
x-microsoft-antispam-prvs: <BYAPR10MB264611250B0A9EA8D3F614DC93C49@BYAPR10MB2646.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1YW24NMmeusr4xnahJLq9fLx94a9+gyyLXNmiYLxQjkMY0p+zavDERXyTMIgW95x/ZHjfmJqnDDYgzrAYrDdoStjyYcdeJg/owGhjyt5RMj8/oPSssRtY5DI0z4gekBoNM5E/dzwaW/DgZRXfoHljT4lqLwYATVzbnc0ZaE4kF/60/WLg/V4UnC56/Ac8yfXkiSACWPX1rbJXbcAacRrvze29aNpN2Q/0NSdZibBQoyDtR7o5wED2fRJAvReQNWIlg3KqI70mpfYcYjKxYiOsWMbZg0NAqyWgl8YOX9TuHtrcYs39EHjbRj9CYdloRNLOlR5bjIYzejxms+TGjDdyIs0BU8xCGAwlUhWuMWicpwNjV8XyGpny7Coh3U/OMwNMmIOPyZ7aYY45HMp+LarAx6L3fln1RS5HSAcobZSqy6HVLI3+1nNoaBTGzlzH5Qep/xuevvotwpqNmSy1ATnDqLIV1MrXHpCIaqszIWize2F1WYukcdvIbKpFnXNi+ygWWjN8kHmezwtyvG5goj6QJHm3vNn7Qu4cNvMNmEQ2h97mdE589g7HB5k1D5rnuWGPfS8D0QgiQ6z2xFnQTcZ3jmsOd9ej5NE2bTHXK/qcyaaDMzgHS6KD9UJbtxB1IvLAmayU0akLDuQoTVkIjX2jQrbGSzgCNXjv7Db1a2PoLHj+hFiksSUWdv2YlT/fxXG5K4G1x+KZI1arq2LpwEWKz6/4TrM1zU2tkfaG1ix6gyc/iq9Dd30fAJIQ2QxHLfI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(346002)(396003)(376002)(366004)(122000001)(38070700005)(8936002)(33656002)(6486002)(6916009)(76116006)(8676002)(2906002)(5660300002)(4326008)(66476007)(66556008)(316002)(64756008)(66446008)(478600001)(38100700002)(36756003)(2616005)(71200400001)(6506007)(54906003)(53546011)(86362001)(186003)(26005)(83380400001)(66946007)(6512007)(91956017)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?p7K9HiZ2YQDN05aRuJENdW/Zx7jJxG3ENBFITIIqjMj2QWXnYpWVMlELsNW0?=
 =?us-ascii?Q?I/xhI97csLRd8/lHD7e0YZGdsN4JGxIrNILqorYCQ9IJNkQPCoSeAWqGpo+H?=
 =?us-ascii?Q?XpoZvxYLXehjvmOw5A9aog4kJfktJRSe0MBydPojFSHsnheBNb7XpPkki/pB?=
 =?us-ascii?Q?kFeXA4Dwt2GoE2cLwfJcN7XU94xP/EvYdKWlbanT4YU56Ff4syuPwpOb/s66?=
 =?us-ascii?Q?T9oBXwIUMCVCisiGaqgUF1u8ltEU6q9jN5sCTTNUNdfBP7D7rzK+kMscinqv?=
 =?us-ascii?Q?OiOnE8gL41OTYSBXvKdXxjK4MlosTrrNQRR22quONAVzhH+ostCaTDwm+ozv?=
 =?us-ascii?Q?D6cBZCiPmfsgHLQwKYDumi7PT856ROd1okGxbHbL5EGQIgi2W1XCJ45eS8sg?=
 =?us-ascii?Q?OyK2VALPzbIsJOJSCOCoE8N7q4Otos0Qus7WcWb2CrW14JNenBkD96t3AXXO?=
 =?us-ascii?Q?GX7Rudv1fATYYmj7QIhZR2VHk/MGRnlWzyl69qY0NAPbrtbw0X9I4z39Cy/Z?=
 =?us-ascii?Q?HT65X4mDe4c6vjTgNO31OXBPTP6+M4T7M92ecoMpCQX60mmgH3E5GLeRlt5m?=
 =?us-ascii?Q?LLYRcTLVREa5R4s/ldHP4kjIrX9elcc0ZMSMsxFWS1Pk6yBbIPhKzFf9KXkl?=
 =?us-ascii?Q?titamBWWbEPmCYxb1rSSKy/J9Dtp84r8FMAQk1CwTq2+Cs+byWg5J7Gu3O18?=
 =?us-ascii?Q?emvCOvqmHUpVpAFa+ziRVJC+ZBxY+97J8lCfcZZGwRVgrXlkPeACPpnW8zco?=
 =?us-ascii?Q?S0S7U1Bt+g2v2nEUuShzJwWJsfQ5KxOZP5y0CvN39ybfIaxj4WpdKdo9H0GC?=
 =?us-ascii?Q?8vqWddMHbr7zS9sKt+w+ahsJMxxIqAy+RudG0GMum3himAQ87Xzb+lSHJKWG?=
 =?us-ascii?Q?cxqpqwZHpaTGrBviAIS8gKAWupGVHy7EACqIP4QzI8u7ZX+l6nUzpFQy1YPO?=
 =?us-ascii?Q?ru3sSFKS5bi5IoEmOVOsb+sJQx7FhbIgc3dFBXaCW3TyvQrymA4BVpea7PyK?=
 =?us-ascii?Q?cotCKc5lhnRFeXSd/zVSMNACytt6HxkuXdxQ578ZUoLAKItHqbv5bAZ61Oy5?=
 =?us-ascii?Q?ZBIfvD2lfDSNZZCaxKrM4i2MV6vE38UYhdr2m/qt3yBXUgrjH7R8dNwfoqNV?=
 =?us-ascii?Q?p8MHbLtF1+d7KwL45/HcXysuNlllZWs5Kw+0l1OMxjW3iv8QKX3XCiPy3Js8?=
 =?us-ascii?Q?oD0XPGjgPxZ9cE7SbnKbem6/NjLp5bwZ+mM7LV8loLhkBy+lY3HtP/9Lajlc?=
 =?us-ascii?Q?Piy6+sz8NjjskBiru9HkH+5wFDpJAeVUKe5mDLEwJVnn3Mw0L27KrwCIKqjP?=
 =?us-ascii?Q?lt1uy7DoDSLH+TNk+iDdMFU+?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A4910C54FE9C11488889B6CD2DC14B9E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ac97f49-96e1-410a-2d90-08d966817684
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2021 22:00:47.3410
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l78j1tztdzZ7gUnlQd/5keN2Bt+sj1cvsZU9zdWnwbj0O5R8bl5lpqYgD9ui2JdQqX89FIicgSUncGGRGOTdHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2646
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10085 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108230149
X-Proofpoint-GUID: DmnLYJBCGcMd7ijnv9hxgNxaoPNTrLWE
X-Proofpoint-ORIG-GUID: DmnLYJBCGcMd7ijnv9hxgNxaoPNTrLWE
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Aug 23, 2021, at 5:58 PM, Bruce Fields <bfields@fieldses.org> wrote:
>=20
> On Mon, Aug 23, 2021 at 09:54:20PM +0000, Chuck Lever III wrote:
>>> On Aug 23, 2021, at 4:44 PM, Bruce Fields <bfields@fieldses.org> wrote:
>>> +static int nlm_unlock_files(struct nlm_file *file)
>>> +{
>>> +	struct file_lock lock;
>>> +	struct file *f;
>>> +
>>> +	lock.fl_type  =3D F_UNLCK;
>>> +	lock.fl_start =3D 0;
>>> +	lock.fl_end   =3D OFFSET_MAX;
>>> +	for (f =3D file->f_file[0]; f <=3D file->f_file[1]; f++) {
>>=20
>> O_RDONLY and O_WRONLY ?
>=20
> I thought they looked weird as loop boundaries.
>=20
>>> @@ -301,7 +305,8 @@ int           nlmsvc_unlock_all_by_ip(struct sockad=
dr *server_addr);
>>>=20
>>> static inline struct inode *nlmsvc_file_inode(struct nlm_file *file)
>>> {
>>> -	return locks_inode(file->f_file);
>>> +	return locks_inode(file->f_file[0] ?
>>> +				file->f_file[0] : file->f_file[1]);
>>=20
>> O_RDONLY and O_WRONLY ?
>=20
> A little less weird.
>=20
> OK, I admit, "looks weird" isn't much of an argument.
>=20
> I say we leave it to whoever cares enough to make the change.

I can update nlmsvc_file_inode() when I apply this version
of the patch, and leave the loops alone.


--
Chuck Lever



