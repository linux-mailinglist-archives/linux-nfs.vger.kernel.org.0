Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD2983AF511
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Jun 2021 20:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbhFUSaC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 21 Jun 2021 14:30:02 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:9942 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231241AbhFUSaB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 21 Jun 2021 14:30:01 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15LIQ3gn006033;
        Mon, 21 Jun 2021 18:27:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=sLqVfz4D6sb7nY6pF6DkaA5iCmGaORzA+q8rqcLwyfI=;
 b=cW+IScn9FivLNooJDWgal3Lo187IVxVGMTxMtJdRz1kxzQGl7neZvI4KZfPHBhHIjfpH
 yqcvhIAnJ+moHdrKVYWuXTggH88LIowQ75+d5S8Oneq5yIjvgn4+7+MVioi/eoZjtxKK
 JUTGqIWqYCURo+thlRhwa3uDsubTwa5VLxbePSYPhQMu6A0LGcSqswfGdnd4JOYwmghL
 D15RoKMXJf6uD7GFhVSl3XGqEvuOpHPrc1q1Ss5UfFuTJbVaHEjhEPW/f4t6HT4Mdz97
 OTKzg/oXfccLRXpj2GYs+UkMvjbgP9Sm/dSUGyRuELtHEbwr/Yl0nHKKDC/RVNklj30F wA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 39a68y2awp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Jun 2021 18:27:42 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15LI9YgR050510;
        Mon, 21 Jun 2021 18:27:41 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2045.outbound.protection.outlook.com [104.47.51.45])
        by aserp3030.oracle.com with ESMTP id 3996mca6pp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Jun 2021 18:27:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QLLP23zei+XGw2yd2+81DtsYuQHnexvHewBJ9uRl/Gmh85P1iP0lgAAyr7k9Ct9S+0da7X+rbLCnAKmvOn98CQi+kA9b7NAmMjdCiF6KCqrlDLJp6q3N5BFDP4Te9sfTHaeondtzkEWi7OLWOMV6uRIM92C8xXMOUrgLSb+tFWtouUj3Ri/Am2dJBMyFH1LZ7QavEybrrZOzg59HpYeR4ncKlPxm3UD2JwNoQwplv0uafsN8+5AA54X72KkBw1PuAeFyX9JFwjNgOGyOcndGNpVd2FtyK/QAMj6ZRe1DcvIa52zhJSTXxpNS9bT2PSLCHQ4ZFqbUyb0VuymAcclGiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sLqVfz4D6sb7nY6pF6DkaA5iCmGaORzA+q8rqcLwyfI=;
 b=YEg2sX3hlx9okvK56ZnM7Fc46Qr9nKN4wFUJO0zI5IP4Fnz0YNa/QofAP3MFvANg8mW+zGbYVq+ZfX1aLAbiYNq+cgswnAj8FxVk+F3eCxusmOwrfYLAduRLsaK4sH7a0ovRi+OgxpHQ9L0WKRa7oQf9aBZgR59FXIGbrYmoJXHSy+KMsWVIsjM93We8oXe4TbZOojn6JWpI3WM/NbVuE67/LsU3PBCe8XXVoYyHnmZPpJkjLpyAjgwRPMZg7rcdr1yNG6x+AuYZ34E/qixq795M9F5znBW7Zb9G0u0L/+aLmn3X3RwCQEiU2sTlSqOxEqq9XIvK4n/17AkmtO0RTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sLqVfz4D6sb7nY6pF6DkaA5iCmGaORzA+q8rqcLwyfI=;
 b=T3KZRLvnPiOuQQDMbwierLDN4dCG+TaxNgAdBZMtDgTDK5H9/wPJxRKy/3rL+rRvpGWrwhGzU9wqcl0KElynBqZQw4HkxaNNlY9PepxmkeABxy6P4U6Gk47Lh3UYz6CvYbFEGb1LK9hhQeMq3nAm8JH3OFTtMJ+nWzeGT+VHHRY=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3029.namprd10.prod.outlook.com (2603:10b6:a03:8d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Mon, 21 Jun
 2021 18:27:39 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::18fc:cb94:ca3:1f94]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::18fc:cb94:ca3:1f94%8]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 18:27:39 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     "trondmy@kernel.org" <trondmy@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Bruce Fields <bfields@redhat.com>
Subject: Re: [PATCH] nfsd: Reduce contention for the nfsd_file nf_rwsem
Thread-Topic: [PATCH] nfsd: Reduce contention for the nfsd_file nf_rwsem
Thread-Index: AQHXY9BFZBFmWOpSekG1W92QMIYbjKsesyqAgAATvQCAAAezgA==
Date:   Mon, 21 Jun 2021 18:27:39 +0000
Message-ID: <F48D54BC-24F6-4E92-9C1E-773E5C5E29DA@oracle.com>
References: <20210617232652.264884-1-trondmy@kernel.org>
 <1669C849-D7DC-46C1-B6B6-F2C79C819710@oracle.com>
 <ff7400e35ec0b227de4546c608d231caed921d5b.camel@hammerspace.com>
In-Reply-To: <ff7400e35ec0b227de4546c608d231caed921d5b.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: hammerspace.com; dkim=none (message not signed)
 header.d=none;hammerspace.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 06f201b6-e399-40d9-70b7-08d934e24057
x-ms-traffictypediagnostic: BYAPR10MB3029:
x-microsoft-antispam-prvs: <BYAPR10MB30293BA1004DA941A2EB0FE9930A9@BYAPR10MB3029.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MdRgeLq93y0JAzGzrFb92UffaxutcFQvjrNEoxmYUB2N4+8j/OsruUg4rLX8kBggfGb/nqi995WzUup9ZP6HesVMBIwPPaRFJkG9HZlhyNPK3+HCbL4SvbR92SC06Ldfx28YR3lrBSQfJxErUavz2uf2Syx/3Dd/HLa0Z3F9sN6u+st5fJkoN6Cnhlnkjmotg8RITacObesZEtiJeT0yDMN9Exf2+vjMwZT+qg+T/gjr3vg8U4SS78CoXsZdp8KF8mXz6tUpl36UZ69iEYYNofnOKjO/dzD/eCJoLWte6+hKfCUPMPpHUaf1qnq5lRp3fYw0ST1+g6eCplD0WNKqs08YObvTQzDZSltBmhSIuxG6qYrylwqEgdzdhVTE5VuO2XRUaXC2CVvcsu5Ls5urjB0SHedvdK0Yy3utAH/OlM2baMMOjuUrUy7pYjEuHfLwaebF98b6MMsrUc+cT2lBWWFPiQ55Lz63Pckh7p1tBIzx0l4oID5piA7WtZpkmoDMqQDGcsG7LrtF2aWggxGLtWkQGVhzzBScQ5ODShFes/Vvhx7Oo39KOXEFkPWOQHg9fDM4t7uevDtXhjKEdsEHSv8+IeEepBZnjXJQrtM/hUk5TmeBamAPWZsBQWqVfiaQtDOWrArOMFEVusqtfxKe4ORz7DFsBA6Lo7LP5KuEGbg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(396003)(346002)(39860400002)(376002)(26005)(186003)(6512007)(6486002)(8676002)(33656002)(4326008)(6506007)(2906002)(5660300002)(53546011)(8936002)(478600001)(83380400001)(2616005)(66946007)(91956017)(316002)(6916009)(76116006)(54906003)(66476007)(66556008)(64756008)(66446008)(122000001)(71200400001)(86362001)(38100700002)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2VC6TEJdspbe0p/V4hu6nz8Irbzgq014S06XLJSUjmvrHwDZavxmTU7b1VLE?=
 =?us-ascii?Q?UdapFgmkfVfZPbiV2oxqVs+hF8zDAH3MPCxfs2KcVhkxQrbHkXQTI9SFk1pD?=
 =?us-ascii?Q?v9HmeJ+YwD+BPoWZkQpRG0o1PJnODxNWcb5oEB4yB8zXXCFYy5BAR5eitlWD?=
 =?us-ascii?Q?YGFzQTgCBf6TkXKmiKMgvGG5xT7GsQjw/EVFjyJdJDPzO7NvTQdktsZgOhv7?=
 =?us-ascii?Q?47VM9MJK1ihDV4ZYFSKjZGKMTu6dfFNpwfq0qDEzuLwNYwH16E+a0Way8kP8?=
 =?us-ascii?Q?4luOPSY31CNMTxFD2dW3FTSpEMHB8+s0F8oOgmL/GEVlDyyLM2x8RgjkwOj1?=
 =?us-ascii?Q?V6Dwt93WatZcp0ATBXxGbpAYMMOXrPheJ/1vVp6A2MWi/qFuh5iNHTMcWd7w?=
 =?us-ascii?Q?ejLccZDggM7RDkNhy15hORJmGMpoENiLvbR4PyjxJeu/sZjMMogIE5eWkgwP?=
 =?us-ascii?Q?IZbNtv0R+rGAoFdaUguq0VHwDzyxQr3TWmLGl4NX0IxYpqjl1eQ6Xco4K1jC?=
 =?us-ascii?Q?n8aSyGu3u7i++7glUp9TopP88bd4HaODB3ZRvTx0SlqvtgKz53olGBalweZW?=
 =?us-ascii?Q?ttOVOS2p/YH1o8f+R8IAzKFeaG8jFdmYP/QoQQYF1/uszruvDkWDqokivzxH?=
 =?us-ascii?Q?NC/avKn3NF0zvPgE//8Hqnt6ZszfJWEeiXVtiRfTwhCWey/EQblN11tn4CEw?=
 =?us-ascii?Q?sAy/xv8ImHdp+fhz0Kp6dPeRewlGPKE4D9PXKn1fLeYnCTWdaWHxwP7H3VRo?=
 =?us-ascii?Q?JdLp1t5ENj/N4K8SSfzKo9HPw67vk+gxasPJzFXZ1cQlaSSIcoNp6kaa3V+W?=
 =?us-ascii?Q?czLnbM43TX2KzW0ahGsO/Klt/T5vQLFXJC02g8xL7ChNabxneWKlN37bCyll?=
 =?us-ascii?Q?EVo7NsaI82SRi9biTSeovZHu0aY+SA16WvIF1AExOH9nmHR1VXOGMEKsI36l?=
 =?us-ascii?Q?52KlLRw8I5I3099bqZmkwGA0rUzE90jpJHy6KfcG2ucSnl4/ppi2ondQrPxK?=
 =?us-ascii?Q?hzk1jBWds5hkHT8p0orxOvgkQQ98JeYkvP0ommFXkKX3NwiEWpuPcijR61GK?=
 =?us-ascii?Q?z8ApeVk/87Yz5/qNIwZqwl+vkNoo1qE4X7qtlkEjgJO8dLxs8HmmnNUcu9lV?=
 =?us-ascii?Q?1EILTkGB6fWPUfgENrVylGA8PkgDfaQ5ICZZWKxGRJ5SZyymWc9uogyfyJb5?=
 =?us-ascii?Q?V8LjVp7VOEIS3s7G+BGkXQ8kXLrLqSxLPtUgTmYatLo61a3dntqt1Wqibr+w?=
 =?us-ascii?Q?J+6QKqhUttcJR1P0LtVofS5s8gdv26bkrGiFpXqUPs/RkU1JnZwjcFBqstMN?=
 =?us-ascii?Q?2b1IphGGx5N9hbrYiLzA5Hxw?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DF78DBB69010A84C9547649DF210C0DE@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06f201b6-e399-40d9-70b7-08d934e24057
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2021 18:27:39.4768
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O9U2LRUJXolVxdnjbtfoB3+FmgGH2Y17Fp4Ty+d3DbQtqZK5k6GaEj0mruZPqHahuFe6mDPJ0cTkT135HFqVRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3029
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10022 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106210107
X-Proofpoint-ORIG-GUID: mEJXt-yRhrY2ePlNm5HaEc0MOZSowXRZ
X-Proofpoint-GUID: mEJXt-yRhrY2ePlNm5HaEc0MOZSowXRZ
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jun 21, 2021, at 2:00 PM, Trond Myklebust <trondmy@hammerspace.com> wr=
ote:
>=20
> On Mon, 2021-06-21 at 16:49 +0000, Chuck Lever III wrote:
>> Hi-
>>=20
>>> On Jun 17, 2021, at 7:26 PM, trondmy@kernel.org wrote:
>>>=20
>>> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>>>=20
>>> When flushing out the unstable file writes as part of a COMMIT
>>> call, try
>>> to perform most of of the data writes and waits outside the
>>> semaphore.
>>>=20
>>> This means that if the client is sending the COMMIT as part of a
>>> memory
>>> reclaim operation, then it can continue performing I/O, with
>>> contention
>>> for the lock occurring only once the data sync is finished.
>>>=20
>>> Fixes: 5011af4c698a ("nfsd: Fix stable writes")
>>> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
>>=20
>> The good news is I've found no functional regressions. The bad
>> news is I haven't seen any difference in performance. Is there
>> a particular test that I can run to observe improvement?
>=20
> I'd expect that re-exported NFS would be the best test since fsync() is
> a high latency operation when the page cache is loaded. You also want
> to use a client with relatively limited memory so that it will try to
> reclaim memory by pushing out dirty pages and doing COMMIT.

I thought I was hitting those low-memory cases with direct I/O testing. <sh=
rug>


>> I wonder about adding a Fixes: tag for a change that the patch
>> description describes as an optimization.
>=20
> I've occasionally hit OOM situations in the re-export case when the r/w
> lock contention causes softerr failure to be serialised.
> i.e. if the server is down, and you're essentially hoping that the nfsd
> threads will give up and return EJUKEBOX/NFS4ERR_DELAY to the client,
> then that lock ensures that threads fail one-by-one (grab lock, write,
> timeout, release lock) instead of being able to all fail at once
> (write, timeout).
>=20
>>=20
>>=20
>>> ---
>>> fs/nfsd/vfs.c | 18 ++++++++++++++++--
>>> 1 file changed, 16 insertions(+), 2 deletions(-)
>>>=20
>>> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
>>> index 15adf1f6ab21..46485c04740d 100644
>>> --- a/fs/nfsd/vfs.c
>>> +++ b/fs/nfsd/vfs.c
>>> @@ -1123,6 +1123,19 @@ nfsd_write(struct svc_rqst *rqstp, struct
>>> svc_fh *fhp, loff_t offset,
>>> }
>>>=20
>>> #ifdef CONFIG_NFSD_V3
>>> +static int
>>> +nfsd_filemap_write_and_wait_range(struct nfsd_file *nf, loff_t
>>> offset,
>>> +                                 loff_t end)
>>> +{
>>> +       struct address_space *mapping =3D nf->nf_file->f_mapping;
>>> +       int ret =3D filemap_fdatawrite_range(mapping, offset, end);
>>> +
>>> +       if (ret)
>>> +               return ret;
>>> +       filemap_fdatawait_range_keep_errors(mapping, offset, end);
>>> +       return 0;
>>> +}
>>> +
>>> /*
>>>  * Commit all pending writes to stable storage.
>>>  *
>>> @@ -1153,10 +1166,11 @@ nfsd_commit(struct svc_rqst *rqstp, struct
>>> svc_fh *fhp,
>>>         if (err)
>>>                 goto out;
>>>         if (EX_ISSYNC(fhp->fh_export)) {
>>> -               int err2;
>>> +               int err2 =3D nfsd_filemap_write_and_wait_range(nf,
>>> offset, end);
>>>=20
>>>                 down_write(&nf->nf_rwsem);
>>> -               err2 =3D vfs_fsync_range(nf->nf_file, offset, end,
>>> 0);
>>> +               if (!err2)
>>> +                       err2 =3D vfs_fsync_range(nf->nf_file, offset,
>>> end, 0);
>>>                 switch (err2) {
>>>                 case 0:
>>>                         nfsd_copy_boot_verifier(verf,
>>> net_generic(nf->nf_net,
>>> --=20
>>> 2.31.1
>>>=20
>>=20
>> --
>> Chuck Lever
>>=20
>>=20
>>=20
>=20
> --=20
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com

--
Chuck Lever



