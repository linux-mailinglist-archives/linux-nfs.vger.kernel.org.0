Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 971955F1276
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Sep 2022 21:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbiI3T3l (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 30 Sep 2022 15:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbiI3T3Z (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 30 Sep 2022 15:29:25 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F2E1D8F38
        for <linux-nfs@vger.kernel.org>; Fri, 30 Sep 2022 12:29:20 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28UITH9K002738;
        Fri, 30 Sep 2022 19:29:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=LzcMn+eBOCawOiE5ZKPsfi7VIqL+3VvFjtQZA7lr/W8=;
 b=VqPxXOq7TvydIIwKbmxSd+lMCNrfLvEo02MbbVsLfsVH9MRVTAzDgR7aESuW7lTANWOr
 OAkuVJNb9sluuDamcFSCIGN+AgtBqEsLV04viioCw5yhncE8j10PkToaNXUavvsJoM1C
 NuvyptYqlJFZy9hGXbvGoItRIz2WEcxEwEFShBLWA3QtgUT13yKAw9SLndhkvWSNJhC4
 389qKaJ3B99PfWZae4doeoVVTs0b4KCkRGkWXK4YMqy1ym4yuYBR3t7D4nP7DaN37XSf
 83OHF6ioIBWghgmKi6UOPWeTy/WUdYEQK9X1AUEbEr1XsFZut8RQ0WGH1Bo7JFGeiFDw tA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jssubrrbn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Sep 2022 19:29:16 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28UJ9tqo034158;
        Fri, 30 Sep 2022 19:29:16 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2175.outbound.protection.outlook.com [104.47.73.175])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jtpqbx428-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Sep 2022 19:29:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fuxr0OSgEl63T2DCf9LOd/SsceAcJMuttJF989xe2pCpZy0yiRh85ImZR9oeWEEMFlP10S/2cyHd8j7w8Ho+O080j3HL6yHlRk2lLWLHeucVUo7spdpUzDN3bKm4iW2hh8htC46grtzeOcaDpNcHfHP16gBXLNw9OMoqyltg5sF0DdC8EXIArPzanY7dwofHmbp2eToZh2Etwsd/aA/+wu2+emmHghqMMdfBANinBf60vuFqwAtr4PXBxtnQQP66I5g9yKI6NiKtQ3p+e3mDnHjTjpj+5ioOH5RCsytSWopst2MyUZ8D57g8z87MToDcDlWgWMZbKRv9JWTT/rGevg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LzcMn+eBOCawOiE5ZKPsfi7VIqL+3VvFjtQZA7lr/W8=;
 b=k827Ht5nTOVFQzr402D9yLIQJo+5L8LtHnxkk3Msprft/erzdvuiOBEU+hIUiC5MlWjNuQjKmmFADmG7ZS35KGjM4jFN8xbE2aB9w6v+3TMb1UsjKnkw2HfppUUSk/SAG36IIljZ02PonMbq7cbY/+hZzwynGU6ARblOZwWj0Zfy2wdQhmuV4EVLvfdNVRa8B8bTf24Gyqq9B6J06ROA9ZtxfpGof4fKg73KNBnWs1tcS4Lmw3ssAP9L8lebhZcjpGviz6PYh6QloSz13Fq8CNupuWcSkVwI/ubYXCM1+HfzA+oBGpjKxAP7Qn7nxFPIUTPlwskQ16mYrGoHERM/FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LzcMn+eBOCawOiE5ZKPsfi7VIqL+3VvFjtQZA7lr/W8=;
 b=Eezq/pgCA+catpcm2VI8eAegbq8trrcMUemAFlgsjPUqDg98yQjI7/tzQh5zV+AQncdRwr7qJmHZf0JciMK63YYhA2JMI7IMe6wP1nmAov1wDJelnjDV38J/qUias9HmHihVhtKlPlIAvrnBcaT+ArghtVgp3JpVZhNJw0+mSeE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB4462.namprd10.prod.outlook.com (2603:10b6:a03:2d7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Fri, 30 Sep
 2022 19:29:14 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%3]) with mapi id 15.20.5676.020; Fri, 30 Sep 2022
 19:29:14 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 3/3] nfsd: fix nfsd_file_unhash_and_dispose
Thread-Topic: [PATCH 3/3] nfsd: fix nfsd_file_unhash_and_dispose
Thread-Index: AQHY1QEStfw/wemJJEuDuuhGYIHZOa34W9WA
Date:   Fri, 30 Sep 2022 19:29:14 +0000
Message-ID: <71D7277C-4E90-476F-A381-BD13E264BA63@oracle.com>
References: <20220930191550.172087-1-jlayton@kernel.org>
 <20220930191550.172087-4-jlayton@kernel.org>
In-Reply-To: <20220930191550.172087-4-jlayton@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SJ0PR10MB4462:EE_
x-ms-office365-filtering-correlation-id: 316103a2-7f5f-4b1b-e384-08daa31a0ee6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hNm9FG57AsBThKXbna9GTTV1OqeyxMEJQO8/rBp4YMPvUFps4gOJtIYAm8k6tL8NbQA4NHd8KIKToc2lIrr9g4ICAi+TSOYJHpCBXnd2HuRA0Q87XcaUMN1gvyVYm/vSY3DdDZVAstgqbQT2RzXDDXB6agHs5O3sWspAW03X9cRch0vrSJKE6fBRpWve+weqGvFIdvoqWN7xoAFd9AHaVyfVLlcIJeKg4+xom28VOw96O13DfOEtnctt5raRDEZAX/K13V7zMjD4TKmScKN4nqUBnsIb654zjGnthIqaKNIoVn5VSw8KtVsgxRAsWF+AgAD7Vm3HYIcQhnAFeEEffpXF3sJrgC0z7ErzvfpMXCuEaS/TxXW4x01UM+ezm9Y0OmYXZLWs19V9wbfybFOhxtmhrpI9rj24Dt17+fYcWh7nCFwApPTA/QnGh0jZ3gvXa/ifTVJbgwamfz7mSdvNGj1e4xNIiIAhMC8AkUN9xlb+b/feMRmJXfAB/DXCxOLb3rvfvlvxNgoyJwnB8xg6U2NniqSmF2VIX+oHHS3q1aDgHg7QFzuf4H9fJSdGnLp99Izfr6YkXb0VNWKuaAg5dXK3RqnYBCZA4iJba+FbsnAxLW5kNqlbdzNs8cijBzkyFIXk7Bjv1t+PK5YtHJ9MNI1/QVSxMxw8U8sT76M2uKyJKeqLeBKIs5C7ZzG2tteZhqkQ/UReY+3hnNJ09Ak5r8OPVOiJBOS7R5bkvt5gZuR/7jQ0hoAV26y+Gk/rZLZfz8icyEsHq3svH9xgZ5Sme1+4SYfwVapTUHg5cszgYoo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(376002)(396003)(346002)(39860400002)(451199015)(2616005)(186003)(86362001)(71200400001)(6512007)(478600001)(6506007)(6916009)(26005)(53546011)(6486002)(122000001)(33656002)(38100700002)(38070700005)(36756003)(83380400001)(66476007)(2906002)(41300700001)(66556008)(91956017)(76116006)(66446008)(316002)(66946007)(64756008)(4326008)(8676002)(5660300002)(8936002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?G9wdp+O5PZuTe99JJrd/vVbj+OhTnzaAnbzZ9ccECxNzRPX/cdOb0PHh15ve?=
 =?us-ascii?Q?zJBXUKpHsIFtIhudhx/OefPQY/GClb9p0oGUDvwaJK6RFiyytunX8liH479E?=
 =?us-ascii?Q?Bi/GtQoucIk0fhZkQbP1DW3XtLwAXUU0xrD5NorOz6xqLJpsTy1T1fwgy952?=
 =?us-ascii?Q?qVT2pGAmj6NqJjewZJzFIaabraIUB+C2cZiJMA+EtMH2B9teFTEARU+pXL2d?=
 =?us-ascii?Q?OLq5Isb5aO5ASa+iBNoZUuAVZ49n7Ps9isbWpZq1YNJV5zsMqPhERJuadcYE?=
 =?us-ascii?Q?BEJ2zyFivUf1LGArewtFKvwiMuAoGtZrZBE5By7aNVZ39DeZKJq92oKEcyi8?=
 =?us-ascii?Q?QMGiwjhwWeZQsnQZ+YdG7gNA3VmnhVCGIhhNqZc66HduMLszsuvmhopwoiEK?=
 =?us-ascii?Q?afO9R64HeAgmq//qQVupmmowZAfFSVSI3VuJ5bdzKmjSDR8IubI2UFkG9ckv?=
 =?us-ascii?Q?IAsrvuVI2yWruKDUNxDCJdn/YgdbJqoKGYGgjLKMR5NxowhfLH57hMydU94F?=
 =?us-ascii?Q?SLBjpgz+r4jn3czRyqESXWMcITWgl0Vp3Z8u7SM7Q0EJy0owx6FD4mnRMvw7?=
 =?us-ascii?Q?skT425qsmLNBQYQhsZbchxgLf94OrGciU+76Xt6Q9kZf2QL+oEvMlGM9jNWR?=
 =?us-ascii?Q?CZ0mGrycZgBzvoyvJB+waIc4QQYwv0yXT26DsOoU6+TACSp14C+lQDlareu3?=
 =?us-ascii?Q?mrXYBsRcmGkfBIk2W6eU1gkgED7/7U5xJ72ZyFwmkU8q2jaZZnB7QpvZ9RMQ?=
 =?us-ascii?Q?daLGhmiPds+1rUB4dWGNv4xOn332av4oj1sJGDv2B9hVGtvm9bZWGVDjMryi?=
 =?us-ascii?Q?lfdBOA+sllQfPyKhwufXr/ej1y5YoPcoUcaGzT1RjKsNeEtQDelL6Aw9zruX?=
 =?us-ascii?Q?enDH/vg5r4GK1xnjWcTGSJ41Ca+8elbY9Hxz8/aQyf0rSdwbxtJsZTF+q40K?=
 =?us-ascii?Q?//fbycuxdCoyWA4Bh0RNIXEuqKg+M5lR9O89dSA7pV66suzcHF7T3cza6CuV?=
 =?us-ascii?Q?jhx9QNHW9sEM/rpQhjx5qWrDA84/gvhqz5ugMvMCJZ5C0LQxAG8O0jrvtwBl?=
 =?us-ascii?Q?5S3bA0mqseIyTldFFJv0SugXenb6DgsN2IKKDo5HNJz7YFw0nJiQRBl7OZ78?=
 =?us-ascii?Q?twKZA2EU30VxsF8ROOugdpV3q9R4fxg670ht+uDoMkjUSwaub7YgTA35FnAV?=
 =?us-ascii?Q?xAuSXwlwbHvL17tHZpJ5p0SLWb/v/gdhcvuC9Ssy+Pv8usLfwC9wGR8TEc/i?=
 =?us-ascii?Q?DOJwY6p0/9rt6XYegLtvljSujP5KqevlNTjzYaw2F755PLT8laiQWNkKgEsM?=
 =?us-ascii?Q?c1thByxuYvLz1bhWIdIuM14UIPtFMV2Ik4mPIq9PpXc11EBO3/K5jEJWfndx?=
 =?us-ascii?Q?Abwx35fidErscNgC0wCH7KxAIckie3MUZFRdfVVfUN5f+LBy4ddh55QlgLjT?=
 =?us-ascii?Q?UCyH3oMr0fIh2E2/bsdqY8hYMR7SBRss7ALhAPvhRc7VICUBbZ1iuGpkR0B6?=
 =?us-ascii?Q?IbKIwml5Ciai69RuElXl08z18DAxq800X1QAlzYMHSg0xVehr/XYIR1Lm7xm?=
 =?us-ascii?Q?T5qh6Kabv2fhL/Pjo5LQAID4y4npAdCFT1pK2XvZQA+5OXyfv2NxCx3DZyXE?=
 =?us-ascii?Q?XQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <70A0228BE95D1743823421E60E22B0D2@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 316103a2-7f5f-4b1b-e384-08daa31a0ee6
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2022 19:29:14.0680
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /PnhQF5iyf4xV/qiVN3DGRawimMnPb3lit1yQyAdR9QGLZqdWY16KUegOo3l7U0cAAMpw5MWWfTRBTRT+d9xLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4462
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-30_04,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 adultscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209300122
X-Proofpoint-GUID: -gQr0W7s181vALA_y5W0_c6QuBhof3Ec
X-Proofpoint-ORIG-GUID: -gQr0W7s181vALA_y5W0_c6QuBhof3Ec
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 30, 2022, at 3:15 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> This function is called two reasons:
>=20
> We're either shutting down and purging the filecache, or we've gotten a
> notification about a file delete, so we want to go ahead and unhash it
> so that it'll get cleaned up when we close.
>=20
> We're either walking the hashtable or doing a lookup in it and we
> don't take a reference in either case. What we want to do in both cases
> is to try and unhash the object and put it on the dispose list if that
> was successful. If it's no longer hashed, then we don't want to touch
> it, with the assumption being that something else is already cleaning
> up the sentinel reference.
>=20
> Instead of trying to selectively decrement the refcount in this
> function, just unhash it, and if that was successful, move it to the
> dispose list. Then, the disposal routine will just clean that up as
> usual.
>=20
> Also, just make this a void function, drop the WARN_ON_ONCE, and the
> comments about deadlocking since the nature of the purported deadlock
> is no longer clear.
>=20
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> fs/nfsd/filecache.c | 32 ++++++--------------------------
> 1 file changed, 6 insertions(+), 26 deletions(-)
>=20
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index 58f4d9267f4a..16bd71a3894e 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -408,19 +408,14 @@ nfsd_file_unhash(struct nfsd_file *nf)
> /*
>  * Return true if the file was unhashed.
>  */

If you're changing the function to return void, the above
comment is now stale.

> -static bool
> +static void
> nfsd_file_unhash_and_dispose(struct nfsd_file *nf, struct list_head *disp=
ose)
> {
> 	trace_nfsd_file_unhash_and_dispose(nf);
> -	if (!nfsd_file_unhash(nf))
> -		return false;
> -	/* keep final reference for nfsd_file_lru_dispose */

This comment has been stale since nfsd_file_lru_dispose() was
renamed or removed. The only trouble I have is there isn't a
comment left that explains why we're not decrementing the hash
table reference here. ("don't have to" is enough to say about
it, but there should be something).


> -	if (refcount_dec_not_one(&nf->nf_ref))
> -		return true;
> -
> -	nfsd_file_lru_remove(nf);
> -	list_add(&nf->nf_lru, dispose);
> -	return true;
> +	if (nfsd_file_unhash(nf)) {
> +		nfsd_file_lru_remove(nf);
> +		list_add(&nf->nf_lru, dispose);
> +	}
> }
>=20
> static void
> @@ -564,8 +559,6 @@ nfsd_file_dispose_list_delayed(struct list_head *disp=
ose)
>  * @lock: LRU list lock (unused)
>  * @arg: dispose list
>  *
> - * Note this can deadlock with nfsd_file_cache_purge.
> - *
>  * Return values:
>  *   %LRU_REMOVED: @item was removed from the LRU
>  *   %LRU_ROTATE: @item is to be moved to the LRU tail
> @@ -750,8 +743,6 @@ nfsd_file_close_inode(struct inode *inode)
>  *
>  * Walk the LRU list and close any entries that have not been used since
>  * the last scan.
> - *
> - * Note this can deadlock with nfsd_file_cache_purge.
>  */
> static void
> nfsd_file_delayed_close(struct work_struct *work)
> @@ -893,16 +884,12 @@ nfsd_file_cache_init(void)
> 	goto out;
> }
>=20
> -/*
> - * Note this can deadlock with nfsd_file_lru_cb.
> - */
> static void
> __nfsd_file_cache_purge(struct net *net)
> {
> 	struct rhashtable_iter iter;
> 	struct nfsd_file *nf;
> 	LIST_HEAD(dispose);
> -	bool del;
>=20
> 	rhashtable_walk_enter(&nfsd_file_rhash_tbl, &iter);
> 	do {
> @@ -912,14 +899,7 @@ __nfsd_file_cache_purge(struct net *net)
> 		while (!IS_ERR_OR_NULL(nf)) {
> 			if (net && nf->nf_net !=3D net)
> 				continue;
> -			del =3D nfsd_file_unhash_and_dispose(nf, &dispose);
> -
> -			/*
> -			 * Deadlock detected! Something marked this entry as
> -			 * unhased, but hasn't removed it from the hash list.
> -			 */
> -			WARN_ON_ONCE(!del);
> -
> +			nfsd_file_unhash_and_dispose(nf, &dispose);
> 			nf =3D rhashtable_walk_next(&iter);
> 		}
>=20
> --=20
> 2.37.3
>=20

--
Chuck Lever



