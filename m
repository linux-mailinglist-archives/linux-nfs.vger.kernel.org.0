Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDDAE56A8C9
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Jul 2022 19:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235240AbiGGQ63 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 7 Jul 2022 12:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235072AbiGGQ61 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 7 Jul 2022 12:58:27 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA732D7D
        for <linux-nfs@vger.kernel.org>; Thu,  7 Jul 2022 09:58:25 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 267EpYB5023513;
        Thu, 7 Jul 2022 16:58:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=0bKJI4OqFt2+H9V9GAF2GdI2Qk/9SI9yCGIguxb4Dkc=;
 b=apALj4CB0J8S+wfVegwH+JOm4BxXA8RWC+PrYBvfhqFWkLXN2WAon7Zf/1FO5/7vRquc
 tIgBFXSF8AahfTNQtqxxUqK8+L4QVg1V8vYvIVS/lEqLkmshqLJDi8x37QduXFttG4Fo
 QonR3xVeYqEgPyFO8+uYkRHTOi/NON1d9q0ur6iaMgi4ADsV2fYSpdVgcalNMBU1nzZ6
 34tj4wdvnRbtULh1Czbui8YmFa2xoaW4h53Lhe7FJMhtJH4eq6tjwsm3N7pO6G6nv5Dr
 JSj+iwJVeNykqMgbTtKJVK0nlYuhXG7rNx0VMaxAXjrLqAniFALd+JC8/hvCJaGBErIV MQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h4ubynug3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Jul 2022 16:58:17 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 267GtM3q011331;
        Thu, 7 Jul 2022 16:58:17 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h4ud75q33-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Jul 2022 16:58:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gX/eySCR54PoxUO//JIQbM2IAwBemIRrMI60yhZYQ7EaCOPtsgv0C6PRPjyBB1H9nSeyhhWrpNanX6uNezoGY6QUGXNQzvJ6veRjYY5knJCQfekfMjvJ8EGvJnmJx/x0da4Swz5yc+8q4AjsQoJy/QrZit5bxoVDiwIjDpbRhedpotXGC0pSxMB5kaQZWbTyrFQTP+ratXlltVv+oxn/JT1f0Kf6FOceQwlIppNpuy/SXOBtmbBZfLARE4SyXh1ghTZBRLvw8s/aMmWi6DpFwHGVkiCM9fcA2z8DNuzcR+WyJQS35c8TYLl7fzl3aN0Zg0HwnWsh/Cx20T2UMlDZeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0bKJI4OqFt2+H9V9GAF2GdI2Qk/9SI9yCGIguxb4Dkc=;
 b=lgyjugdWHQG+8gBt8T2VrNUALWTud5hE4FNgeR6xMZXrniRQG1GAM0U1a9kcB1vGWOkso19+tWMaUQw4HvFrmMM4gwx2iV68fcCsO8OxsnQDokyEHUjsMh7dVbcWR1L35T7AF79eu040QLnstlY2u7LRczcaNKS5vLNDTXoYfpzaKImaWnepa8ybmhayDXCr7Ysl5QUIt/MkX7Gv1ZQplI6/JZwvpVqyZbm4ksIYYMUUwIf4zwTmJxdjwsBztXpk9eXqR780aps8lovQOhFyClpewddjoJINke4rbjms724s9b4DAV1x+h9cxbI8TZaSOwKsHtUfXx/0DkK7Ehl1oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0bKJI4OqFt2+H9V9GAF2GdI2Qk/9SI9yCGIguxb4Dkc=;
 b=mUe2tHyWP/DS/tT3AmJ8Graq2ZNF2fRF2wx2LXuSn9EaeM98uQ6RMY/ZAvf16uWWskMMEtoi7kVrNd1LAcoGFQ8VU6xTijPXwm3uUZhV8vcFM4z9mu5KdbYvi6vJJ5XKze8BTwRRUU1IYQovn4DQ5Y5eiauqO8FmKqQc5h+PgJI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW4PR10MB5773.namprd10.prod.outlook.com (2603:10b6:303:18d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.20; Thu, 7 Jul
 2022 16:58:14 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703%5]) with mapi id 15.20.5395.021; Thu, 7 Jul 2022
 16:58:14 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@redhat.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH RFC] NFSD: Bump the ref count on nf_inode
Thread-Topic: [PATCH RFC] NFSD: Bump the ref count on nf_inode
Thread-Index: AQHYkhpvRGZ0dTioakaq+LLAbdwSV61zIGIAgAAA5oA=
Date:   Thu, 7 Jul 2022 16:58:14 +0000
Message-ID: <98746C90-BB21-4FE5-9000-BCC33662F8F1@oracle.com>
References: <165720933938.1180.14325183467695610136.stgit@klimt.1015granger.net>
 <f3dc1a01fae6759a350adabf944892417a63d529.camel@redhat.com>
In-Reply-To: <f3dc1a01fae6759a350adabf944892417a63d529.camel@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f3401a3e-49c0-445f-b844-08da6039e1f2
x-ms-traffictypediagnostic: MW4PR10MB5773:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V28yrXAwNAHgfPtOXmONBU4oZf8wVGIWIN4xbFfUKvZo4XrmKjFjv2QX18y+dkuOKj/vkW3ci89JqEiLJzJKDpv7J8rPWDjIpeUElW81UpF60l/FGrFHxEcriX+dQO/qfaUYVFjTzaB2VWSRUIsPnjSctht6lwNYU9xNBDPXMdvnjQo83JDglkxSO15orYw9oP+hUoXgSP4oR35L8DpcBjNXlvT1FfWjrG/aJ1NP/lvtPWpfKsBgdUeYJL3hMdRDUPGph0ag2wUGw78RCKL4r2HDEU8ZrO25dJNTFVGUNB6mCWNS2tGSLD2b6eDpvRQXcC8/pnUq40JLSqUGTfb7z10wVFHCfOskuIOA6+mBx8aKoGY5bWAotRHAlzB98tDW1oLKsja2g+NsFh72IR8yDF/WCMtFXMYqv3apSVMsIlg3HWdAGYyqifNhVL85qWpg2hyE2BWbJi2NmLImRkVqKu2NXKF7EAvoCiivPFx9RREUxmx8f3k2IHyZyLpZYPNhNLni6sg7IRQcfACM3lsGaQf1IgJvL1R/9+Dwj1g43vaIWjPmezECiaDEhdUagSrQCj1fppOdh4fEf4ula30Mh2NbkMzjDRo+tIXioSUtDVgXH/4APNgb+gaT6lSkMgoNvifg1rs2v29cGHh3oOqox8WO838mRS/M5BhwPPZ0oEVPzBAs24Hiu4zgdaeW7DkD9Gawd/iDTy5sQhVkV8WveqhLci4nLPVTpjMJHzNB2I8KskKMb/MEHXvEjX5YZfjWH5AwLrmC7xRwn86taG0gdy1kfHO1un7QF/hEEsAM3yTgGZ0lAh9XyC7WG7011+x5epqQ70EzmOk4EkBQapUWBEDLorLmIuSxUf8zM+JnzmQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(136003)(39860400002)(376002)(346002)(366004)(86362001)(33656002)(38070700005)(38100700002)(36756003)(53546011)(41300700001)(2616005)(186003)(6512007)(83380400001)(122000001)(66476007)(2906002)(26005)(8936002)(4326008)(6486002)(316002)(6916009)(66446008)(66946007)(71200400001)(64756008)(91956017)(66556008)(8676002)(5660300002)(76116006)(6506007)(478600001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dsyhmbMZO/DOLx8vY+mo8VbKb3S9pztsAehI79I2XN6AkQkQBQLhzSiw27b+?=
 =?us-ascii?Q?SGyhN5vJVFZQssQpuVM7DJDZFYR6K1gFmC2goS6Hlq9Vz1pTW07Ll3BuPoWm?=
 =?us-ascii?Q?P/0hebdkh+oejBF5iBgniKFI1U9dVCsVd38wa8ZV/av9AycPbRTFdPm9m/cj?=
 =?us-ascii?Q?por133VmxwNQbsm1Gr9uyrpfwnvY/VfQqoYz21sjrjNrBdlAWNYR/DvoYynU?=
 =?us-ascii?Q?dRlK43ijBoEbLFR4Y37ipl3z/t66yW3sgDOhAEPP6QpoEwCUqcTH5NYDUE4a?=
 =?us-ascii?Q?2rfaAdraGHYy2MWWiy0isnHBSArnwb5ZSHfH+93B/XzO7HVol0OL09tW5OFu?=
 =?us-ascii?Q?2qpYbn73Yq/zqBc+r3cPU2MMsjczJmHutAd8G6r1HbXXeeTYWxJyN59/25Xm?=
 =?us-ascii?Q?H/GJWrsi8Ki2HtFCrIkf12b7h9IDAH5hPnWrlF4gfm8Tt5PiZhCPNgWBsXsC?=
 =?us-ascii?Q?xGCJAUYOvNtl9d+tUUsKA2QfCDcOWjArpAsIYJ6MNzyvUSSl2wyF5oAZL3xA?=
 =?us-ascii?Q?WrgSG42xGaTOC/wM6tR8/OlLOfpnrnwlTMCes3VAJy83aj5ClvItuJFglZra?=
 =?us-ascii?Q?9lkyx/wOOaqaCWjEx2lfmVG5lzivtFeA6Fe+TTNxnOkpwOA1tr4JysnNTj35?=
 =?us-ascii?Q?sxOajn5FuPRDIvJeJwL/csSGiKvABKd8UajxjO5ZxCxWyatorcrjUDwIIpqg?=
 =?us-ascii?Q?sW0WGTWnn94raI55HNnWmjiBqhekG6JIlVnubnv0cQF5u+ARkH0XmlCaE2Es?=
 =?us-ascii?Q?QfvZlQB0PXtLsg831gWtjicT4XxUYMwNpY7blf+qrxelNDKrKF0v8i0y/6RO?=
 =?us-ascii?Q?u/UQe7O5m/7802iXTfkdS/Bme7tHpUljxn9AE+pqcv4SJlQY9xS3f3vwZmHD?=
 =?us-ascii?Q?4gWFGuzoZDrZyeJsgHZc3S4xVbVUyEQCPkJbky3ha4toAukBZiZYEhyLFylj?=
 =?us-ascii?Q?IOvpNMxPVphnfLOH3CJRom91Bt1ZMLqtgkdG31HEd/jOpKmlk/O3MGUyi5Rh?=
 =?us-ascii?Q?t33cTz9pYi+8GwIxoROSqhAA2E272QnkGGKMBHjDuOb3+hhSzn2ip/Ggbxo7?=
 =?us-ascii?Q?240nHsRzYFTdcbXCD0UM8/1IEtDYCI/1Cw+pTo+c6dGqHrnSuLBycoD3Zk5S?=
 =?us-ascii?Q?FB3DZP3eY3M5JPwSwuRtRdlSMSlf+MCvp9Vdym8D07YBHZ/+1VltcV7OvB0a?=
 =?us-ascii?Q?JNYCLRc3Qyyex9Ru+wTAjrIJcoPX19Dxp/b1+dP2IRHfUzJglXO+T3lI9fgT?=
 =?us-ascii?Q?jVMmhLwoJNF14Anyrks9zL4yEFlrz69tiznsFYOuQiv83BHRVUTMPO+oxsUw?=
 =?us-ascii?Q?eNFPv9GcFUYlo0IKPXfO6uWBiLZx48GKzhwWCqXpPQgL6cMqkcF3Ugj6L90d?=
 =?us-ascii?Q?vOVCBRs41RFQP+F1X0qwzun5PWR4yrWLxUdTgs6moCqvSycWrFCyt7uZQHXS?=
 =?us-ascii?Q?uVoXPtg2RUA+MkWFmLg1IhskJU2ZzCg25AcuestJQ62sKezOMOn527gEWKnS?=
 =?us-ascii?Q?ZSSxhWNK/hgH+QDytkQm86yHIFfhHwgSzNemvKt1VegD1JLX543yWgqc2M3/?=
 =?us-ascii?Q?nPB+1S6yLdhok94524QvshdNyhx2jUhs1Ea5AkYQpHrt/e84HzWfK7xPhilq?=
 =?us-ascii?Q?Nw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <30C893887055F944A66E90F2EA10DC75@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3401a3e-49c0-445f-b844-08da6039e1f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2022 16:58:14.6372
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ufU7aG7F9aAviSMgYeLzAvU9D0LBHkYd7vdzSVP6g9UIcFMbOVKbUN82ubU+5DOJjr9yY1y4WLZjC98M8OzFWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5773
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-07_13:2022-06-28,2022-07-07 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 adultscore=0 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207070068
X-Proofpoint-GUID: RS07WFDvFh64caKA7t47gVBoHx8n5dxe
X-Proofpoint-ORIG-GUID: RS07WFDvFh64caKA7t47gVBoHx8n5dxe
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 7, 2022, at 12:55 PM, Jeff Layton <jlayton@redhat.com> wrote:
>=20
> On Thu, 2022-07-07 at 11:58 -0400, Chuck Lever wrote:
>> The documenting comment for struct nf_file states:
>>=20
>> /*
>> * A representation of a file that has been opened by knfsd. These are ha=
shed
>> * in the hashtable by inode pointer value. Note that this object doesn't
>> * hold a reference to the inode by itself, so the nf_inode pointer shoul=
d
>> * never be dereferenced, only used for comparison.
>> */
>>=20
>> However, nfsd_file_mark_find_or_create() does dereference the pointer st=
ored
>> in this field.
>>=20
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>> fs/nfsd/filecache.c | 3 +++
>> fs/nfsd/filecache.h | 4 +---
>> 2 files changed, 4 insertions(+), 3 deletions(-)
>>=20
>> Hi Jeff-
>>=20
>> I'm still testing this one, but I'm wondering what you think of it.
>> I did hit a KASAN splat that might be related, but it's not 100%
>> reproducible.
>>=20
>=20
> My first thought is "what the hell was I thinking, tracking an inode
> field without holding a reference to it?"
>=20
> But now that I look, the nf_inode value only gets dereferenced in one
> place -- nfs4_show_superblock, and I think that's a bug. The comments
> over struct nfsd_file say:
>=20
> "Note that this object doesn't hold a reference to the inode by itself,
> so the nf_inode pointer should never be dereferenced, only used for
> comparison."
>=20
> We should probably annotate nf_inode better. __attribute__((noderef))
> maybe? It would also be good to make nfs4_show_superblock use a
> different way to get the sb.
>=20
> In any case, this is unlikely to fix anything unless the crash happened
> in nfs4_show_superblock.

Thanks for the look. I will treat this as a clean-up, then, and see
what can be done about nfsd_file_mark_find_or_create() and
nfs4_show_superblock().


>> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
>> index 9cb2d590c036..7b43bb427a53 100644
>> --- a/fs/nfsd/filecache.c
>> +++ b/fs/nfsd/filecache.c
>> @@ -180,6 +180,7 @@ nfsd_file_alloc(struct inode *inode, unsigned int ma=
y, unsigned int hashval,
>> 		nf->nf_cred =3D get_current_cred();
>> 		nf->nf_net =3D net;
>> 		nf->nf_flags =3D 0;
>> +		ihold(inode);
>> 		nf->nf_inode =3D inode;
>> 		nf->nf_hashval =3D hashval;
>> 		refcount_set(&nf->nf_ref, 1);
>> @@ -210,6 +211,7 @@ nfsd_file_free(struct nfsd_file *nf)
>> 		fput(nf->nf_file);
>> 		flush =3D true;
>> 	}
>> +	iput(nf->nf_inode);
>> 	call_rcu(&nf->nf_rcu, nfsd_file_slab_free);
>> 	return flush;
>> }
>> @@ -940,6 +942,7 @@ nfsd_do_file_acquire(struct svc_rqst *rqstp, struct =
svc_fh *fhp,
>> 	if (nf =3D=3D NULL)
>> 		goto open_file;
>> 	spin_unlock(&nfsd_file_hashtbl[hashval].nfb_lock);
>> +	iput(new->nf_inode);
>> 	nfsd_file_slab_free(&new->nf_rcu);
>>=20
>> wait_for_construction:
>> diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
>> index 1da0c79a5580..01fbf6e88cce 100644
>> --- a/fs/nfsd/filecache.h
>> +++ b/fs/nfsd/filecache.h
>> @@ -24,9 +24,7 @@ struct nfsd_file_mark {
>>=20
>> /*
>> * A representation of a file that has been opened by knfsd. These are ha=
shed
>> - * in the hashtable by inode pointer value. Note that this object doesn=
't
>> - * hold a reference to the inode by itself, so the nf_inode pointer sho=
uld
>> - * never be dereferenced, only used for comparison.
>> + * in the hashtable by inode pointer value.
>> */
>> struct nfsd_file {
>> 	struct hlist_node	nf_node;
>>=20
>>=20
>=20
> --=20
> Jeff Layton <jlayton@redhat.com>

--
Chuck Lever



