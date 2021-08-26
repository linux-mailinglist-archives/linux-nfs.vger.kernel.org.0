Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B38CD3F89D6
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Aug 2021 16:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbhHZOL0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 26 Aug 2021 10:11:26 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:65108 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229451AbhHZOLZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 26 Aug 2021 10:11:25 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17QAmucE001424;
        Thu, 26 Aug 2021 14:10:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=HRnnUY++ekeekIFBhUU8v9BTkmjhAryQRobB+cvrsHk=;
 b=D7wfXAg18hY6X7GmIKHbtenFZuZSCy39IuFlzIeAE+RXCxzSdloAZQX8b/Uc57u/oJTl
 2Y7KGCKqU2dzbdxl9T6MeXfUJhAKaq6a3QYrNI2o7cJKHvrFxUnJDmHpMormx7Gg2JFf
 3rbZpBpJjEoUCmt7rC067OOHdmNxPXPHLq8qVKc2lPgUs1WenSfHHZLTeAt2uOHclZCK
 LwN/hsuANyHEFaUUeN+WZCXHZefWV0nPoMQfo1zZGw9ucFkkm5apeLrY3Hwi/WOeDpGr
 WWx5cMGp4LJ9362EtBV2zitFo17kowmsnjYuYtGAgZR9arfRGOfFOCDIdnXJAuUJAEuZ 5Q== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=HRnnUY++ekeekIFBhUU8v9BTkmjhAryQRobB+cvrsHk=;
 b=ZX72N8KmMVubrV6bc8RZiRYQbnjS+dtbEcWCcBHZ0D0vLHkOuFcs+SOMw7/OnR1fgD0z
 JPTFRU3/WJqcwNea/hlVQg4cMRPhk77GcT4ALO9B3dzmNw97Edup1XqX0Txfr6nXKMuU
 cCQBjFABPk3vTIU51InFoRPPAmGtqAmlRIGQhLArSdhJMa3D++TGjyNh8x8VrGxj45kj
 1tr318VBpRzNmY69OOMnKnWDMfRvoPD9yUsghNUAjZobERFjKrx/k/ZnqLm1X9hvxXko
 fA5lYY0Ml6vj5s6xFHEtAC1ho0fOPvXwtMlR0NIucKxd4J3WW3+wLKpIl/kTEwbLbgfP UA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ap0xp9dp4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Aug 2021 14:10:31 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17QDtXRl017066;
        Thu, 26 Aug 2021 14:10:30 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by userp3020.oracle.com with ESMTP id 3akb903sa3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Aug 2021 14:10:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DsRG2+l9SGgXPww/gYyt5OROextTbknWGdRggPcJCGe5uMhWCQu1F8l0UnwHWmgPZfvYvi49QdFN11lg5Rlwo5U7I8vtC9scLB0IbKvS+14yg1PQEcOt3LlOcV2XSSBQycBpkjVjXG6hFuAOYOnSk3BiaG4oOAGzV0W6hyEhXoOZmR6NOVpQ/fM8EFAxQqiKukDpu5wCGrG5fW6XDX6NbwWncgjUlMqCO73Nuku+UgbLoW5xa1LHTw9vvIXDQ/GQptBkrozk92fUZ3zSsTj8X4EE8nn22j/dH2AuJceUNMla9KgUpwH8JQ2oq2LNDd4VHuZLQCwd0gr17NQ6d+lT7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HRnnUY++ekeekIFBhUU8v9BTkmjhAryQRobB+cvrsHk=;
 b=MwuQSXZdS84f+E/CEqXTej72ybNSbRwY0I4UAXwe6c5A3qzwkkCn8eG7IRUxl8n4RFU4AW+/1fyVq0ZGz0EthzVHRec6LbjQM+yqIunW0JrQCkhgHthIBLpDkT2dXggALkFd6APA1URstF1Egvt7ynnfV9pO5jDFWdAoGkHAloTF3pY9jbFGS3bkXMpJGpGzAWhJnBfOxHwunk+bWD7DWcEwmNEH7p87xjxgCX8BtATiSDkLMLDAi2PCqAMaY4zBnDuwyJrHpseePdQmQAt+HbkgDq0gt1gt1SDQ1UHJaO/mEY8ZlmTlnXKW1CeY8gb4IFv15YvFfM/4HmZJUaiwqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HRnnUY++ekeekIFBhUU8v9BTkmjhAryQRobB+cvrsHk=;
 b=KeeW6Mu02yv6Y71EmzMU9MOnh/ZIN1Wc50Wd3kvQtpeZ9njrgrn0sdxRb2Fg3agdHhJmqsEE+wW5t5AFlfsnOOZ8DOQWBO23yLuuP5qZZb34jSEVr3+eblEvR88RiXsBZcBaoH1yq9hbt0k5QNwTbEV/EofgxgjyB4r4YVpXZDI=
Received: from CO1PR10MB4673.namprd10.prod.outlook.com (2603:10b6:303:91::8)
 by CO6PR10MB5426.namprd10.prod.outlook.com (2603:10b6:5:35e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Thu, 26 Aug
 2021 14:10:25 +0000
Received: from CO1PR10MB4673.namprd10.prod.outlook.com
 ([fe80::d14b:45fc:ebf2:8a94]) by CO1PR10MB4673.namprd10.prod.outlook.com
 ([fe80::d14b:45fc:ebf2:8a94%9]) with mapi id 15.20.4436.024; Thu, 26 Aug 2021
 14:10:25 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Bruce Fields <bfields@fieldses.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] NFSD: drop support for ancient file-handles
Thread-Topic: [PATCH] NFSD: drop support for ancient file-handles
Thread-Index: AQHXmjLRKub6PusaSECzAaQsRvVIyauF09MA
Date:   Thu, 26 Aug 2021 14:10:25 +0000
Message-ID: <BDD839B0-7837-4421-940B-6DB9EC31043E@oracle.com>
References: <162995209561.7591.4202079352301963089@noble.neil.brown.name>
In-Reply-To: <162995209561.7591.4202079352301963089@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cd0893b4-7a70-4c3e-1cff-08d9689b3ff0
x-ms-traffictypediagnostic: CO6PR10MB5426:
x-microsoft-antispam-prvs: <CO6PR10MB54260845956C3F132A0524D393C79@CO6PR10MB5426.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SLFRtWhTkcIpIt0NYSVClgSqUrG1/ENIL1QDGEU9M+g05tiMERgwl/weneKCrAB0zljNKfxKNeeUjZQWmyBjL4fXzztIWPrI6FCgatMmzAZ1XOUWgfb978iZOf+JbatrLPC4gsturhet6is3T1qrK9R3Yr/Z8R6sF/H385Z3z4/uflEiajhbH8HaQkUt2+rBHZhVawN4M12WYfXCLmYFF0R07G95gOvn2OulN1KFw1TyjCRSTOjjMVHDPLeE8GY6xZuUt6VD8dn7ykrff2JWhCZgNS8Fq3Tkb3xLO2mVXgfpyqpLjHvQh+Li1UdcinufYSqzlYi72EaFSXukVn9Wu50LUBELnX70zkx3OW0FdFworQ5/8Sgfq5Piz2Fa607aKb2RwhOHZyrdX+VaOlwxJcKt9RihfIHzea9xthyELID155aleIxW96PN4Nt3yRIwDTwRC4c61hc8rfrTbEo+lEYx2VPwxlh7LBky5uHDt7BHQhaOkRkTQ6LBh71vDvPc7eMNB9QVzGAHunJCq1tT4BcB4WWPfeCK0eN4LMQP6z7KT7c1ZY+bj8wElsWug0V4gk/90i7sQRoJeH7UcKKDuzbm588eLY1VkZLO6i96Mlri2VtQ1z5ujjSwI7e4WgpuwxShIBL0EYz4/bgW7dUypIgAb4fXtcFY8tWuXxaWWw6KG91vVq9MRxBc0AJEXzr1w2MO2f6vtA3/iCU4gi8Gt03ZNPwUm0UgRHh5hdxuIlnFTPiRoGJ34+2c+BxRq/3oLjfhz5urPGNuj1p0SigYmU6B3BGil1sdRwm/idQtDhgAJyc1+6KWKDq49CefFaA/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4673.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66476007)(76116006)(498600001)(8936002)(2616005)(66446008)(53546011)(54906003)(6506007)(66946007)(6512007)(91956017)(122000001)(66556008)(186003)(64756008)(38070700005)(2906002)(83380400001)(38100700002)(33656002)(30864003)(71200400001)(26005)(6916009)(4326008)(86362001)(5660300002)(8676002)(36756003)(966005)(6486002)(45980500001)(579004)(559001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EV7V8OViLwMdTNM4yp/SEQdoAAar3qEA5fnCYiQsuhY1uqpKzem5OFY2Ec2J?=
 =?us-ascii?Q?c59DHsT3Iksho8eDkm1k7HKRr4d/zt50ZSbRSKedTwGHh2QXuVpYXGN41EJ6?=
 =?us-ascii?Q?BgQ+JqxNe3oGRaurdoKanLsZa7A/vvByyAakk3N0uByk1yssJSCM3rum/aBP?=
 =?us-ascii?Q?ms613YX9PrfWWPfizvF2jihqFYC0zwDDhV5D2RaVg+AdHV4pYCa9VXcEWJwg?=
 =?us-ascii?Q?MQF219o+CAJ6vO4rLGiZuzU8RrjJhCyphFzcJ+Z0GWVaITpBtouLYujDBt1c?=
 =?us-ascii?Q?8XBMfP3sRIMjNcNuzvRv2u4agpg1YcT3gmTtiwQtxF3x9AYea6uyFN1175yC?=
 =?us-ascii?Q?YRFA3anE1wl0SlBZbsmZ7B1eFBCmfb83np3BPOlf3m5/OncX65T2HWEeog8b?=
 =?us-ascii?Q?s6VbqnQZQehCMoJNwR+2QP0NgspGwcsk25tToqAhAUeb75T+pc41exbGQCN0?=
 =?us-ascii?Q?d8bes0nl2T2B9PhMniytrV8vHzZOVNyGa5iklvvVLXn55n9LhFLMwiKmXwDu?=
 =?us-ascii?Q?uciuhCmJdu5p0kgNTr6lBglSzxxujpGP8BKzUUtAJfBNJ8SRO+1OuUMuTjmu?=
 =?us-ascii?Q?LzSXea+V1d84XQe1XJXNdvsZkt5s70r+l3IQmd0NK8Coz8nlfEKlQpdHEmh1?=
 =?us-ascii?Q?MH50xVlVyAvVzL4qgHbDtbrgBs6w41D/F86r1J59RuB8bGWPkaEoGw9NB0BA?=
 =?us-ascii?Q?wAvO7mSy7/j7VjZvlHsj+p8ZFPjkyUE3v3Vtsk860GvtVJYpSL8AJLINEMyo?=
 =?us-ascii?Q?0ct/0rS+fTSom7fOTcHVCRrt43os3X8QVl12NprmuwWBw8Ijh9kK/aOK2fC5?=
 =?us-ascii?Q?uXXgQHL2COybjuZV+H1KgDlZXM9xQQVQ1uyW6U+q11cNca2h5BfFYJmt76eF?=
 =?us-ascii?Q?23BxGy9vQaMleha3Gqw8cs5f/avip+si777JnOpp0nXp3l1GjoN4xGIQMGlj?=
 =?us-ascii?Q?pguenJ1gCQaL9LMOH4ccr0JXKlzoFzS9E4x0tyf/veeCeFyzS5JXKl8uz6xM?=
 =?us-ascii?Q?TwZ6xS8477yeuLpRRTwaUJ81UR8VTgeQUYpe4Of8dfm4XYSv1yHhCwpf9x8z?=
 =?us-ascii?Q?e2vMyM2UsmIDx+omTwveVFjcl6Zs77uJEAKfOqO4WikYk1fZYI0NG7oZkr2P?=
 =?us-ascii?Q?9+C47rLVeED7Dep55FNu1AsZYRYlfPSuwOBOF6n2CpW/0FSmUJV6Aj1aQ6AL?=
 =?us-ascii?Q?aSjhrDb5KNQ0GWRvk6xn89KtxYSU3Ji8TiY39X+DZFwvs1hQpCUGRdNUOUtH?=
 =?us-ascii?Q?0nceDKIn+zO9ZdM5ZUW3aBwiwH5vqeXXYe3y8VDlsfS8/SLvwf5FPcjboC3y?=
 =?us-ascii?Q?5vnhXmIyOdvvyOqfVAjMfgsj?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E9EDF4FFDDB74A4C9457AFAF671072C7@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4673.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd0893b4-7a70-4c3e-1cff-08d9689b3ff0
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2021 14:10:25.0550
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p+8AxBiIEEOctchQx7NRDtdqhm8JRPbKF779fvE1akgXRGhntE+8I0eE36rRmU9pMwqCXVu7dFo7fyIFakCfIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5426
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10088 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108260084
X-Proofpoint-GUID: VTM3pmL__i-xqBjc-ubXefL4B5QSrjKQ
X-Proofpoint-ORIG-GUID: VTM3pmL__i-xqBjc-ubXefL4B5QSrjKQ
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Aug 26, 2021, at 12:28 AM, NeilBrown <neilb@suse.de> wrote:
>=20
>=20
> File-handles not in the "new" or "version 1" format have not been handed
> out for new mounts since Linux 2.4 which was released 20 years ago.
> I think it is safe to say that no such file handles are still in use,
> and that we can drop support for them.
>=20
> This patch also moves the nfsfh.h from the include/uapi directory into
> fs/nfsd.  I can find no evidence of it being used anywhere outside the
> kernel.  Certainly nfs-utils and wireshark do not use it.
>=20
> fh_base and fh_pad are occasionally used to refer to the whole
> filehandle.  These are replaced with "fh_raw" which is hopefully more
> meaningful.
>=20
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>=20
> I found
> https://www.spinics.net/lists/linux-nfs/msg43280.html
> "Re: [PATCH] nfsd: clean up fh_auth usage"
> from 2014 where moving nfsfh.h out of uapi was considered but not
> actioned. Christoph said he would "do some research if the
> uapi <linux/nfsd/*.h> headers are used anywhere at all".  I can find no
> report on the result of that research.  My own research turned up
> nothing.
>=20
> Thanks,
> NeilBrown

Hi Neil-

I have no philosophical objection to this clean up, but I'm
concerned a bit about timing. It's a large patch, and 5.15
should be opening on Sunday. I would prefer this to go into
5.16, if that's OK with you?


> fs/nfsd/lockd.c                 |   2 +-
> fs/nfsd/nfs3xdr.c               |   4 +-
> fs/nfsd/nfs4callback.c          |   2 +-
> fs/nfsd/nfs4proc.c              |   2 +-
> fs/nfsd/nfs4state.c             |   4 +-
> fs/nfsd/nfs4xdr.c               |   4 +-
> fs/nfsd/nfsctl.c                |   6 +-
> fs/nfsd/nfsfh.c                 | 177 +++++++++++---------------------
> fs/nfsd/nfsfh.h                 |  55 +++++++++-
> fs/nfsd/nfsxdr.c                |   4 +-
> include/uapi/linux/nfsd/nfsfh.h | 116 ---------------------
> 11 files changed, 126 insertions(+), 250 deletions(-)
> delete mode 100644 include/uapi/linux/nfsd/nfsfh.h
>=20
> diff --git a/fs/nfsd/lockd.c b/fs/nfsd/lockd.c
> index 3f5b3d7b62b7..74d1630e7994 100644
> --- a/fs/nfsd/lockd.c
> +++ b/fs/nfsd/lockd.c
> @@ -33,7 +33,7 @@ nlm_fopen(struct svc_rqst *rqstp, struct nfs_fh *f, str=
uct file **filp)
> 	/* must initialize before using! but maxsize doesn't matter */
> 	fh_init(&fh,0);
> 	fh.fh_handle.fh_size =3D f->size;
> -	memcpy((char*)&fh.fh_handle.fh_base, f->data, f->size);
> +	memcpy((char*)&fh.fh_handle.fh_raw, f->data, f->size);
> 	fh.fh_export =3D NULL;
>=20
> 	nfserr =3D nfsd_open(rqstp, &fh, S_IFREG, NFSD_MAY_LOCK, filp);
> diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
> index 0a5ebc52e6a9..3d37923afb06 100644
> --- a/fs/nfsd/nfs3xdr.c
> +++ b/fs/nfsd/nfs3xdr.c
> @@ -92,7 +92,7 @@ svcxdr_decode_nfs_fh3(struct xdr_stream *xdr, struct sv=
c_fh *fhp)
> 		return false;
> 	fh_init(fhp, NFS3_FHSIZE);
> 	fhp->fh_handle.fh_size =3D size;
> -	memcpy(&fhp->fh_handle.fh_base, p, size);
> +	memcpy(&fhp->fh_handle.fh_raw, p, size);
>=20
> 	return true;
> }
> @@ -131,7 +131,7 @@ svcxdr_encode_nfs_fh3(struct xdr_stream *xdr, const s=
truct svc_fh *fhp)
> 	*p++ =3D cpu_to_be32(size);
> 	if (size)
> 		p[XDR_QUADLEN(size) - 1] =3D 0;
> -	memcpy(p, &fhp->fh_handle.fh_base, size);
> +	memcpy(p, &fhp->fh_handle.fh_raw, size);
>=20
> 	return true;
> }
> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> index 0f8b10f363e7..11f8715d92d6 100644
> --- a/fs/nfsd/nfs4callback.c
> +++ b/fs/nfsd/nfs4callback.c
> @@ -121,7 +121,7 @@ static void encode_nfs_fh4(struct xdr_stream *xdr, co=
nst struct knfsd_fh *fh)
>=20
> 	BUG_ON(length > NFS4_FHSIZE);
> 	p =3D xdr_reserve_space(xdr, 4 + length);
> -	xdr_encode_opaque(p, &fh->fh_base, length);
> +	xdr_encode_opaque(p, &fh->fh_raw, length);
> }
>=20
> /*
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 486c5dba4b65..4872b9519a72 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -519,7 +519,7 @@ nfsd4_putfh(struct svc_rqst *rqstp, struct nfsd4_comp=
ound_state *cstate,
>=20
> 	fh_put(&cstate->current_fh);
> 	cstate->current_fh.fh_handle.fh_size =3D putfh->pf_fhlen;
> -	memcpy(&cstate->current_fh.fh_handle.fh_base, putfh->pf_fhval,
> +	memcpy(&cstate->current_fh.fh_handle.fh_raw, putfh->pf_fhval,
> 	       putfh->pf_fhlen);
> 	ret =3D fh_verify(rqstp, &cstate->current_fh, 0, NFSD_MAY_BYPASS_GSS);
> #ifdef CONFIG_NFSD_V4_2_INTER_SSC
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index fa67ecd5fe63..d66b4be99063 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -1010,7 +1010,7 @@ static int delegation_blocked(struct knfsd_fh *fh)
> 		}
> 		spin_unlock(&blocked_delegations_lock);
> 	}
> -	hash =3D jhash(&fh->fh_base, fh->fh_size, 0);
> +	hash =3D jhash(&fh->fh_raw, fh->fh_size, 0);
> 	if (test_bit(hash&255, bd->set[0]) &&
> 	    test_bit((hash>>8)&255, bd->set[0]) &&
> 	    test_bit((hash>>16)&255, bd->set[0]))
> @@ -1029,7 +1029,7 @@ static void block_delegations(struct knfsd_fh *fh)
> 	u32 hash;
> 	struct bloom_pair *bd =3D &blocked_delegations;
>=20
> -	hash =3D jhash(&fh->fh_base, fh->fh_size, 0);
> +	hash =3D jhash(&fh->fh_raw, fh->fh_size, 0);
>=20
> 	spin_lock(&blocked_delegations_lock);
> 	__set_bit(hash&255, bd->set[bd->new]);
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 7abeccb975b2..a54b2845473b 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -3110,7 +3110,7 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct s=
vc_fh *fhp,
> 		p =3D xdr_reserve_space(xdr, fhp->fh_handle.fh_size + 4);
> 		if (!p)
> 			goto out_resource;
> -		p =3D xdr_encode_opaque(p, &fhp->fh_handle.fh_base,
> +		p =3D xdr_encode_opaque(p, &fhp->fh_handle.fh_raw,
> 					fhp->fh_handle.fh_size);
> 	}
> 	if (bmval0 & FATTR4_WORD0_FILEID) {
> @@ -3667,7 +3667,7 @@ nfsd4_encode_getfh(struct nfsd4_compoundres *resp, =
__be32 nfserr, struct svc_fh
> 	p =3D xdr_reserve_space(xdr, len + 4);
> 	if (!p)
> 		return nfserr_resource;
> -	p =3D xdr_encode_opaque(p, &fhp->fh_handle.fh_base, len);
> +	p =3D xdr_encode_opaque(p, &fhp->fh_handle.fh_raw, len);
> 	return 0;
> }
>=20
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index c2c3d9077dc5..449b57e5e328 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -395,12 +395,12 @@ static ssize_t write_filehandle(struct file *file, =
char *buf, size_t size)
> 	auth_domain_put(dom);
> 	if (len)
> 		return len;
> -=09
> +
> 	mesg =3D buf;
> 	len =3D SIMPLE_TRANSACTION_LIMIT;
> -	qword_addhex(&mesg, &len, (char*)&fh.fh_base, fh.fh_size);
> +	qword_addhex(&mesg, &len, (char*)&fh.fh_raw, fh.fh_size);
> 	mesg[-1] =3D '\n';
> -	return mesg - buf;=09
> +	return mesg - buf;
> }
>=20
> /*
> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> index c475d2271f9c..7695c0f1eefe 100644
> --- a/fs/nfsd/nfsfh.c
> +++ b/fs/nfsd/nfsfh.c
> @@ -154,11 +154,12 @@ static inline __be32 check_pseudo_root(struct svc_r=
qst *rqstp,
> static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct svc_fh *f=
hp)
> {
> 	struct knfsd_fh	*fh =3D &fhp->fh_handle;
> -	struct fid *fid =3D NULL, sfid;
> +	struct fid *fid =3D NULL;
> 	struct svc_export *exp;
> 	struct dentry *dentry;
> 	int fileid_type;
> 	int data_left =3D fh->fh_size/4;
> +	int len;
> 	__be32 error;
>=20
> 	error =3D nfserr_stale;
> @@ -167,48 +168,35 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *r=
qstp, struct svc_fh *fhp)
> 	if (rqstp->rq_vers =3D=3D 4 && fh->fh_size =3D=3D 0)
> 		return nfserr_nofilehandle;
>=20
> -	if (fh->fh_version =3D=3D 1) {
> -		int len;
> -
> -		if (--data_left < 0)
> -			return error;
> -		if (fh->fh_auth_type !=3D 0)
> -			return error;
> -		len =3D key_len(fh->fh_fsid_type) / 4;
> -		if (len =3D=3D 0)
> -			return error;
> -		if  (fh->fh_fsid_type =3D=3D FSID_MAJOR_MINOR) {
> -			/* deprecated, convert to type 3 */
> -			len =3D key_len(FSID_ENCODE_DEV)/4;
> -			fh->fh_fsid_type =3D FSID_ENCODE_DEV;
> -			/*
> -			 * struct knfsd_fh uses host-endian fields, which are
> -			 * sometimes used to hold net-endian values. This
> -			 * confuses sparse, so we must use __force here to
> -			 * keep it from complaining.
> -			 */
> -			fh->fh_fsid[0] =3D new_encode_dev(MKDEV(ntohl((__force __be32)fh->fh_=
fsid[0]),
> -							ntohl((__force __be32)fh->fh_fsid[1])));
> -			fh->fh_fsid[1] =3D fh->fh_fsid[2];
> -		}
> -		data_left -=3D len;
> -		if (data_left < 0)
> -			return error;
> -		exp =3D rqst_exp_find(rqstp, fh->fh_fsid_type, fh->fh_fsid);
> -		fid =3D (struct fid *)(fh->fh_fsid + len);
> -	} else {
> -		__u32 tfh[2];
> -		dev_t xdev;
> -		ino_t xino;
> -
> -		if (fh->fh_size !=3D NFS_FHSIZE)
> -			return error;
> -		/* assume old filehandle format */
> -		xdev =3D old_decode_dev(fh->ofh_xdev);
> -		xino =3D u32_to_ino_t(fh->ofh_xino);
> -		mk_fsid(FSID_DEV, tfh, xdev, xino, 0, NULL);
> -		exp =3D rqst_exp_find(rqstp, FSID_DEV, tfh);
> +	if (fh->fh_version !=3D 1)
> +		return error;
> +
> +	if (--data_left < 0)
> +		return error;
> +	if (fh->fh_auth_type !=3D 0)
> +		return error;
> +	len =3D key_len(fh->fh_fsid_type) / 4;
> +	if (len =3D=3D 0)
> +		return error;
> +	if  (fh->fh_fsid_type =3D=3D FSID_MAJOR_MINOR) {
> +		/* deprecated, convert to type 3 */
> +		len =3D key_len(FSID_ENCODE_DEV)/4;
> +		fh->fh_fsid_type =3D FSID_ENCODE_DEV;
> +		/*
> +		 * struct knfsd_fh uses host-endian fields, which are
> +		 * sometimes used to hold net-endian values. This
> +		 * confuses sparse, so we must use __force here to
> +		 * keep it from complaining.
> +		 */
> +		fh->fh_fsid[0] =3D new_encode_dev(MKDEV(ntohl((__force __be32)fh->fh_f=
sid[0]),
> +						      ntohl((__force __be32)fh->fh_fsid[1])));
> +		fh->fh_fsid[1] =3D fh->fh_fsid[2];
> 	}
> +	data_left -=3D len;
> +	if (data_left < 0)
> +		return error;
> +	exp =3D rqst_exp_find(rqstp, fh->fh_fsid_type, fh->fh_fsid);
> +	fid =3D (struct fid *)(fh->fh_fsid + len);
>=20
> 	error =3D nfserr_stale;
> 	if (IS_ERR(exp)) {
> @@ -253,18 +241,7 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rq=
stp, struct svc_fh *fhp)
> 	if (rqstp->rq_vers > 2)
> 		error =3D nfserr_badhandle;
>=20
> -	if (fh->fh_version !=3D 1) {
> -		sfid.i32.ino =3D fh->ofh_ino;
> -		sfid.i32.gen =3D fh->ofh_generation;
> -		sfid.i32.parent_ino =3D fh->ofh_dirino;
> -		fid =3D &sfid;
> -		data_left =3D 3;
> -		if (fh->ofh_dirino =3D=3D 0)
> -			fileid_type =3D FILEID_INO32_GEN;
> -		else
> -			fileid_type =3D FILEID_INO32_GEN_PARENT;
> -	} else
> -		fileid_type =3D fh->fh_fileid_type;
> +	fileid_type =3D fh->fh_fileid_type;
>=20
> 	if (fileid_type =3D=3D FILEID_ROOT)
> 		dentry =3D dget(exp->ex_path.dentry);
> @@ -452,20 +429,6 @@ static void _fh_update(struct svc_fh *fhp, struct sv=
c_export *exp,
> 	}
> }
>=20
> -/*
> - * for composing old style file handles
> - */
> -static inline void _fh_update_old(struct dentry *dentry,
> -				  struct svc_export *exp,
> -				  struct knfsd_fh *fh)
> -{
> -	fh->ofh_ino =3D ino_t_to_u32(d_inode(dentry)->i_ino);
> -	fh->ofh_generation =3D d_inode(dentry)->i_generation;
> -	if (d_is_dir(dentry) ||
> -	    (exp->ex_flags & NFSEXP_NOSUBTREECHECK))
> -		fh->ofh_dirino =3D 0;
> -}
> -
> static bool is_root_export(struct svc_export *exp)
> {
> 	return exp->ex_path.dentry =3D=3D exp->ex_path.dentry->d_sb->s_root;
> @@ -600,35 +563,21 @@ fh_compose(struct svc_fh *fhp, struct svc_export *e=
xp, struct dentry *dentry,
> 	fhp->fh_dentry =3D dget(dentry); /* our internal copy */
> 	fhp->fh_export =3D exp_get(exp);
>=20
> -	if (fhp->fh_handle.fh_version =3D=3D 0xca) {
> -		/* old style filehandle please */
> -		memset(&fhp->fh_handle.fh_base, 0, NFS_FHSIZE);
> -		fhp->fh_handle.fh_size =3D NFS_FHSIZE;
> -		fhp->fh_handle.ofh_dcookie =3D 0xfeebbaca;
> -		fhp->fh_handle.ofh_dev =3D  old_encode_dev(ex_dev);
> -		fhp->fh_handle.ofh_xdev =3D fhp->fh_handle.ofh_dev;
> -		fhp->fh_handle.ofh_xino =3D
> -			ino_t_to_u32(d_inode(exp->ex_path.dentry)->i_ino);
> -		fhp->fh_handle.ofh_dirino =3D ino_t_to_u32(parent_ino(dentry));
> -		if (inode)
> -			_fh_update_old(dentry, exp, &fhp->fh_handle);
> -	} else {
> -		fhp->fh_handle.fh_size =3D
> -			key_len(fhp->fh_handle.fh_fsid_type) + 4;
> -		fhp->fh_handle.fh_auth_type =3D 0;
> -
> -		mk_fsid(fhp->fh_handle.fh_fsid_type,
> -			fhp->fh_handle.fh_fsid,
> -			ex_dev,
> -			d_inode(exp->ex_path.dentry)->i_ino,
> -			exp->ex_fsid, exp->ex_uuid);
> -
> -		if (inode)
> -			_fh_update(fhp, exp, dentry);
> -		if (fhp->fh_handle.fh_fileid_type =3D=3D FILEID_INVALID) {
> -			fh_put(fhp);
> -			return nfserr_opnotsupp;
> -		}
> +	fhp->fh_handle.fh_size =3D
> +		key_len(fhp->fh_handle.fh_fsid_type) + 4;
> +	fhp->fh_handle.fh_auth_type =3D 0;
> +
> +	mk_fsid(fhp->fh_handle.fh_fsid_type,
> +		fhp->fh_handle.fh_fsid,
> +		ex_dev,
> +		d_inode(exp->ex_path.dentry)->i_ino,
> +		exp->ex_fsid, exp->ex_uuid);
> +
> +	if (inode)
> +		_fh_update(fhp, exp, dentry);
> +	if (fhp->fh_handle.fh_fileid_type =3D=3D FILEID_INVALID) {
> +		fh_put(fhp);
> +		return nfserr_opnotsupp;
> 	}
>=20
> 	return 0;
> @@ -649,23 +598,19 @@ fh_update(struct svc_fh *fhp)
> 	dentry =3D fhp->fh_dentry;
> 	if (d_really_is_negative(dentry))
> 		goto out_negative;
> -	if (fhp->fh_handle.fh_version !=3D 1) {
> -		_fh_update_old(dentry, fhp->fh_export, &fhp->fh_handle);
> -	} else {
> -		if (fhp->fh_handle.fh_fileid_type !=3D FILEID_ROOT)
> -			return 0;
> +	if (fhp->fh_handle.fh_fileid_type !=3D FILEID_ROOT)
> +		return 0;
>=20
> -		_fh_update(fhp, fhp->fh_export, dentry);
> -		if (fhp->fh_handle.fh_fileid_type =3D=3D FILEID_INVALID)
> -			return nfserr_opnotsupp;
> -	}
> +	_fh_update(fhp, fhp->fh_export, dentry);
> +	if (fhp->fh_handle.fh_fileid_type =3D=3D FILEID_INVALID)
> +		return nfserr_opnotsupp;
> 	return 0;
> out_bad:
> 	printk(KERN_ERR "fh_update: fh not verified!\n");
> 	return nfserr_serverfault;
> out_negative:
> 	printk(KERN_ERR "fh_update: %pd2 still negative!\n",
> -		dentry);
> +	       dentry);
> 	return nfserr_serverfault;
> }
>=20
> @@ -702,12 +647,12 @@ char * SVCFH_fmt(struct svc_fh *fhp)
> 	static char buf[80];
> 	sprintf(buf, "%d: %08x %08x %08x %08x %08x %08x",
> 		fh->fh_size,
> -		fh->fh_base.fh_pad[0],
> -		fh->fh_base.fh_pad[1],
> -		fh->fh_base.fh_pad[2],
> -		fh->fh_base.fh_pad[3],
> -		fh->fh_base.fh_pad[4],
> -		fh->fh_base.fh_pad[5]);
> +		fh->fh_raw[0],
> +		fh->fh_raw[1],
> +		fh->fh_raw[2],
> +		fh->fh_raw[3],
> +		fh->fh_raw[4],
> +		fh->fh_raw[5]);
> 	return buf;
> }
>=20
> diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
> index 6106697adc04..f36234c474dc 100644
> --- a/fs/nfsd/nfsfh.h
> +++ b/fs/nfsd/nfsfh.h
> @@ -10,9 +10,56 @@
>=20
> #include <linux/crc32.h>
> #include <linux/sunrpc/svc.h>
> -#include <uapi/linux/nfsd/nfsfh.h>
> #include <linux/iversion.h>
> #include <linux/exportfs.h>
> +#include <linux/nfs4.h>
> +
> +/*
> + * The file handle starts with a sequence of four-byte words.
> + * The first word contains a version number (1) and three descriptor byt=
es
> + * that tell how the remaining 3 variable length fields should be handle=
d.
> + * These three bytes are auth_type, fsid_type and fileid_type.
> + *
> + * All four-byte values are in host-byte-order.
> + *
> + * The auth_type field is deprecated and must be set to 0.
> + *
> + * The fsid_type identifies how the filesystem (or export point) is
> + *    encoded.
> + *  Current values:
> + *     0  - 4 byte device id (ms-2-bytes major, ls-2-bytes minor), 4byte=
 inode number
> + *        NOTE: we cannot use the kdev_t device id value, because kdev_t=
.h
> + *              says we mustn't.  We must break it up and reassemble.
> + *     1  - 4 byte user specified identifier
> + *     2  - 4 byte major, 4 byte minor, 4 byte inode number - DEPRECATED
> + *     3  - 4 byte device id, encoded for user-space, 4 byte inode numbe=
r
> + *     4  - 4 byte inode number and 4 byte uuid
> + *     5  - 8 byte uuid
> + *     6  - 16 byte uuid
> + *     7  - 8 byte inode number and 16 byte uuid
> + *
> + * The fileid_type identified how the file within the filesystem is enco=
ded.
> + *   The values for this field are filesystem specific, exccept that
> + *   filesystems must not use the values '0' or '0xff'. 'See enum fid_ty=
pe'
> + *   in include/linux/exportfs.h for currently registered values.
> + */
> +
> +struct knfsd_fh {
> +	unsigned int	fh_size;	/*
> +					 * Points to the current size while
> +					 * building a new file handle.
> +					 */
> +	union {
> +		__u32			fh_raw[NFS4_FHSIZE/4];
> +		struct {
> +			__u8		fh_version;	/* =3D=3D 1 */
> +			__u8		fh_auth_type;	/* deprecated */
> +			__u8		fh_fsid_type;
> +			__u8		fh_fileid_type;
> +			__u32		fh_fsid[]; /* flexible-array member */
> +		};
> +	};
> +};
>=20
> static inline __u32 ino_t_to_u32(ino_t ino)
> {
> @@ -188,7 +235,7 @@ static inline void
> fh_copy_shallow(struct knfsd_fh *dst, struct knfsd_fh *src)
> {
> 	dst->fh_size =3D src->fh_size;
> -	memcpy(&dst->fh_base, &src->fh_base, src->fh_size);
> +	memcpy(&dst->fh_raw, &src->fh_raw, src->fh_size);
> }
>=20
> static __inline__ struct svc_fh *
> @@ -203,7 +250,7 @@ static inline bool fh_match(struct knfsd_fh *fh1, str=
uct knfsd_fh *fh2)
> {
> 	if (fh1->fh_size !=3D fh2->fh_size)
> 		return false;
> -	if (memcmp(fh1->fh_base.fh_pad, fh2->fh_base.fh_pad, fh1->fh_size) !=3D=
 0)
> +	if (memcmp(fh1->fh_raw, fh2->fh_raw, fh1->fh_size) !=3D 0)
> 		return false;
> 	return true;
> }
> @@ -227,7 +274,7 @@ static inline bool fh_fsid_match(struct knfsd_fh *fh1=
, struct knfsd_fh *fh2)
>  */
> static inline u32 knfsd_fh_hash(const struct knfsd_fh *fh)
> {
> -	return ~crc32_le(0xFFFFFFFF, (unsigned char *)&fh->fh_base, fh->fh_size=
);
> +	return ~crc32_le(0xFFFFFFFF, (unsigned char *)&fh->fh_raw, fh->fh_size)=
;
> }
> #else
> static inline u32 knfsd_fh_hash(const struct knfsd_fh *fh)
> diff --git a/fs/nfsd/nfsxdr.c b/fs/nfsd/nfsxdr.c
> index a06c05fe3b42..082449c7d0db 100644
> --- a/fs/nfsd/nfsxdr.c
> +++ b/fs/nfsd/nfsxdr.c
> @@ -64,7 +64,7 @@ svcxdr_decode_fhandle(struct xdr_stream *xdr, struct sv=
c_fh *fhp)
> 	if (!p)
> 		return false;
> 	fh_init(fhp, NFS_FHSIZE);
> -	memcpy(&fhp->fh_handle.fh_base, p, NFS_FHSIZE);
> +	memcpy(&fhp->fh_handle.fh_raw, p, NFS_FHSIZE);
> 	fhp->fh_handle.fh_size =3D NFS_FHSIZE;
>=20
> 	return true;
> @@ -78,7 +78,7 @@ svcxdr_encode_fhandle(struct xdr_stream *xdr, const str=
uct svc_fh *fhp)
> 	p =3D xdr_reserve_space(xdr, NFS_FHSIZE);
> 	if (!p)
> 		return false;
> -	memcpy(p, &fhp->fh_handle.fh_base, NFS_FHSIZE);
> +	memcpy(p, &fhp->fh_handle.fh_raw, NFS_FHSIZE);
>=20
> 	return true;
> }
> diff --git a/include/uapi/linux/nfsd/nfsfh.h b/include/uapi/linux/nfsd/nf=
sfh.h
> deleted file mode 100644
> index 427294dd56a1..000000000000
> --- a/include/uapi/linux/nfsd/nfsfh.h
> +++ /dev/null
> @@ -1,116 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> -/*
> - * This file describes the layout of the file handles as passed
> - * over the wire.
> - *
> - * Copyright (C) 1995, 1996, 1997 Olaf Kirch <okir@monad.swb.de>
> - */
> -
> -#ifndef _UAPI_LINUX_NFSD_FH_H
> -#define _UAPI_LINUX_NFSD_FH_H
> -
> -#include <linux/types.h>
> -#include <linux/nfs.h>
> -#include <linux/nfs2.h>
> -#include <linux/nfs3.h>
> -#include <linux/nfs4.h>
> -
> -/*
> - * This is the old "dentry style" Linux NFSv2 file handle.
> - *
> - * The xino and xdev fields are currently used to transport the
> - * ino/dev of the exported inode.
> - */
> -struct nfs_fhbase_old {
> -	__u32		fb_dcookie;	/* dentry cookie - always 0xfeebbaca */
> -	__u32		fb_ino;		/* our inode number */
> -	__u32		fb_dirino;	/* dir inode number, 0 for directories */
> -	__u32		fb_dev;		/* our device */
> -	__u32		fb_xdev;
> -	__u32		fb_xino;
> -	__u32		fb_generation;
> -};
> -
> -/*
> - * This is the new flexible, extensible style NFSv2/v3/v4 file handle.
> - * by Neil Brown <neilb@cse.unsw.edu.au> - March 2000
> - *
> - * The file handle starts with a sequence of four-byte words.
> - * The first word contains a version number (1) and three descriptor byt=
es
> - * that tell how the remaining 3 variable length fields should be handle=
d.
> - * These three bytes are auth_type, fsid_type and fileid_type.
> - *
> - * All four-byte values are in host-byte-order.
> - *
> - * The auth_type field is deprecated and must be set to 0.
> - *
> - * The fsid_type identifies how the filesystem (or export point) is
> - *    encoded.
> - *  Current values:
> - *     0  - 4 byte device id (ms-2-bytes major, ls-2-bytes minor), 4byte=
 inode number
> - *        NOTE: we cannot use the kdev_t device id value, because kdev_t=
.h
> - *              says we mustn't.  We must break it up and reassemble.
> - *     1  - 4 byte user specified identifier
> - *     2  - 4 byte major, 4 byte minor, 4 byte inode number - DEPRECATED
> - *     3  - 4 byte device id, encoded for user-space, 4 byte inode numbe=
r
> - *     4  - 4 byte inode number and 4 byte uuid
> - *     5  - 8 byte uuid
> - *     6  - 16 byte uuid
> - *     7  - 8 byte inode number and 16 byte uuid
> - *
> - * The fileid_type identified how the file within the filesystem is enco=
ded.
> - *   The values for this field are filesystem specific, exccept that
> - *   filesystems must not use the values '0' or '0xff'. 'See enum fid_ty=
pe'
> - *   in include/linux/exportfs.h for currently registered values.
> - */
> -struct nfs_fhbase_new {
> -	union {
> -		struct {
> -			__u8		fb_version_aux;	/* =3D=3D 1, even =3D> nfs_fhbase_old */
> -			__u8		fb_auth_type_aux;
> -			__u8		fb_fsid_type_aux;
> -			__u8		fb_fileid_type_aux;
> -			__u32		fb_auth[1];
> -			/*	__u32		fb_fsid[0]; floating */
> -			/*	__u32		fb_fileid[0]; floating */
> -		};
> -		struct {
> -			__u8		fb_version;	/* =3D=3D 1, even =3D> nfs_fhbase_old */
> -			__u8		fb_auth_type;
> -			__u8		fb_fsid_type;
> -			__u8		fb_fileid_type;
> -			__u32		fb_auth_flex[]; /* flexible-array member */
> -		};
> -	};
> -};
> -
> -struct knfsd_fh {
> -	unsigned int	fh_size;	/* significant for NFSv3.
> -					 * Points to the current size while building
> -					 * a new file handle
> -					 */
> -	union {
> -		struct nfs_fhbase_old	fh_old;
> -		__u32			fh_pad[NFS4_FHSIZE/4];
> -		struct nfs_fhbase_new	fh_new;
> -	} fh_base;
> -};
> -
> -#define ofh_dcookie		fh_base.fh_old.fb_dcookie
> -#define ofh_ino			fh_base.fh_old.fb_ino
> -#define ofh_dirino		fh_base.fh_old.fb_dirino
> -#define ofh_dev			fh_base.fh_old.fb_dev
> -#define ofh_xdev		fh_base.fh_old.fb_xdev
> -#define ofh_xino		fh_base.fh_old.fb_xino
> -#define ofh_generation		fh_base.fh_old.fb_generation
> -
> -#define	fh_version		fh_base.fh_new.fb_version
> -#define	fh_fsid_type		fh_base.fh_new.fb_fsid_type
> -#define	fh_auth_type		fh_base.fh_new.fb_auth_type
> -#define	fh_fileid_type		fh_base.fh_new.fb_fileid_type
> -#define	fh_fsid			fh_base.fh_new.fb_auth_flex
> -
> -/* Do not use, provided for userspace compatiblity. */
> -#define	fh_auth			fh_base.fh_new.fb_auth
> -
> -#endif /* _UAPI_LINUX_NFSD_FH_H */
> --=20
> 2.32.0
>=20
>=20

--
Chuck Lever



