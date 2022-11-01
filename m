Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4809615285
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Nov 2022 20:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiKATpO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Nov 2022 15:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiKATpN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 1 Nov 2022 15:45:13 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760CD11C05
        for <linux-nfs@vger.kernel.org>; Tue,  1 Nov 2022 12:45:12 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A1InfW8024853;
        Tue, 1 Nov 2022 19:45:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Txx5a2COag3Cr317M9AWwyhELBUcaWtZxQs1Q9sKODE=;
 b=rODGZkOeyLcBKCNMG7TsUerEQvKZGpEjyxwt3LOui2YH1FMkfV93wiNIwSxgVfwSZZlp
 ug/EycNr8gfvOfXWr0hlcCmuzkctBX7uaIR3gNXFjIj73zM4wInKIXBfsl7IWGU5tppL
 R0Rg4wkXr60yPMblap64LoDK0ytatTlObkUOuPDThDJyOFVQiVtb/j+MXO3xH7S6dpV4
 Ml+RnBMiWTfd4jiYCZjepIvuHHrK2TcvANh47KktMIuRzAy0/q1jVpGhTYKO1NkEs1vL
 V/1gJmFclDnbeIc89ddeuIJsbRsHmJpWfzxxtatkCOyCpv2qE3ZuPu1iaqChdsEO6XjE ng== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgts17ss7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Nov 2022 19:45:06 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A1HgRXR002911;
        Tue, 1 Nov 2022 19:45:05 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2049.outbound.protection.outlook.com [104.47.56.49])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kgtm4tnpr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Nov 2022 19:45:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P3vmfoa0kL/hmxPZYcoF4nmBV4LSewqSyi5ZLT94MFamxjlPy8AOWSXEO2ZwBqIO9YM1aIxKR6imTr0JpWW9OwBc1j7JqRMIHD2fS3eggv6Gwr2JlpiWMISV7xUCdkQe9j8wvyuC8YThM+ewWIBdngGO9XfAFIzio/GrYp6+HhNIcg4uAcDgcd6wYOg/ijV+a9GY+EGI8exteYAjLBRmLcdcTY800qmxlTnADCqP+2/c7U++wOhGLTMCgz4Dq8NDiGZLiJXUoplQ8UMIF9CFkp1Ln/d629t38c7uhRpKCeIWkPq+7ltEkmYw+7HjaOxkUCUGFRwEh8NroTzDXiUVuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Txx5a2COag3Cr317M9AWwyhELBUcaWtZxQs1Q9sKODE=;
 b=KpnkVYOWvmSwU2pClJlX4DKOaNQAVXChY8W4kjoy+qVaRYVufGkcDspwJgYvb2IrvJouEft63zRU41cxLA2krT4zaS1m74bK6fsTG2biJmq/uatdMWTiyLCCbrQ0P23dpQjUoSAD+YVjZNT1QRjM/+/ctq+AV7HTbKHt8nlFZp7sprIxq7yLlhHukQrHlVejuR9Jk5wQNHfk4NJw8AWkv84c8SLuTN8BE6q4k9aSDPvq4Z7iGbd9bLgn4jkOEHTLI9phO3qZCRRo0cz6K+RZv37S98h1GBC7u/dO58Uh9IW9GucXW96fljrOqyGF6Xv7bBv+PgpGnzC23K7bsRRo4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Txx5a2COag3Cr317M9AWwyhELBUcaWtZxQs1Q9sKODE=;
 b=py0c0mYx2Dh6RdsIC1viO5tH9VBdbJNrAztwJSvPSWkhrGznDpIqvOReS44R2FZ+b3ACqUBaBxl5XxMWKu+qyOJAi32/5Zp5Fdn5nFxIGXK5hRmcRkA716JoNNn/VQBmY9kHAZ1QduhqFY+y6rT1BzyeL2gDZdc5HX614pVcvpg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB4430.namprd10.prod.outlook.com (2603:10b6:a03:2d5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Tue, 1 Nov
 2022 19:45:02 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%3]) with mapi id 15.20.5769.021; Tue, 1 Nov 2022
 19:45:02 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Neil Brown <neilb@suse.de>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v5 4/5] nfsd: close race between unhashing and LRU
 addition
Thread-Topic: [PATCH v5 4/5] nfsd: close race between unhashing and LRU
 addition
Thread-Index: AQHY7gDL+y7FIybaF067dT9j2NqLWK4qeNsA
Date:   Tue, 1 Nov 2022 19:45:02 +0000
Message-ID: <0A6BF2E4-5A7D-49BA-8292-FBD8E8693F54@oracle.com>
References: <20221101144647.136696-1-jlayton@kernel.org>
 <20221101144647.136696-5-jlayton@kernel.org>
In-Reply-To: <20221101144647.136696-5-jlayton@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SJ0PR10MB4430:EE_
x-ms-office365-filtering-correlation-id: 656c55d2-6f1b-4a0f-6728-08dabc419190
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jgRtlSIau4GhsJnWNL5oP/NoNMRcqo6RqTTNZoWN1dV6RXDzJYQgX+dTCRqjliKl3rM+BtqXMzY7LqTE1W4R0JIg2hkz7yE6tSwncqOBGW4ZbbG4gYj9wnv/RfhxkSgl/WfdRzOBG8CSDSwFS8WOMUiXexDTR7e/Xkz2QcyjTFC+CuT28bUe7OqHN9ymhcicFij65QQlLYVyf+SvKoHW5aaDnDU9hEY1WJQ1PactDHFEgmNX2OGlkz5aBALL0spc+4dg8VzuKK1y+Y8ptmkG1iHy5TlJSThoLDtyGrGznWmYcW6x7MyCBDLnqrTvEy7ZgyplBYIoteeF+/SP1S8UhhozL1VYBP+mSA0r6plfkEDeTICAig0AkHNkW8fQ4AgczQGrr/Ion+cNTkZWiV/Q2KUFpL2TN7qBN+yEi/vzhcjbdUWj6pfITEb1KaUATZJCxT2NZ2mVM9NuSSfkCBPl7r5jPM0hSKIXA+t4szwAU1UtprngtL64Kp1JqWbkAZQ478y/e515kRuzQctXGkT8iNe16YBecOXn82EFpTkT5okhEV6V110YBpTbojmpD6hEKb21JQB5I0vMaHH4M/a3uHxmbp0YThIcG/mclsgU/aacZhTC8QtqsCqWuseEi2WeyNH0B2LASua+5s7FoZxRKH35cpy48r8Txv9/fKPDochhJbJRtHMfdkrA7MpAWRPOCF9yhtHYmEayDUi+0moSCD9CUxmqnPyiLsiEQEW2sRhBgL3kT9RfWSeUkVJXdLj7XHWOzNczt7T638kCUxg863HuGLlgK3o/PJICB3POB2Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(136003)(39860400002)(366004)(396003)(451199015)(36756003)(5660300002)(2906002)(38100700002)(122000001)(33656002)(83380400001)(86362001)(38070700005)(186003)(6512007)(2616005)(26005)(53546011)(54906003)(71200400001)(478600001)(6486002)(316002)(41300700001)(6916009)(91956017)(8936002)(8676002)(66946007)(66446008)(64756008)(66476007)(66556008)(4326008)(6506007)(76116006)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GPfYlqbuHCAmreNotmzeMO3QG0yuvkGihiymp+IQg1RavpCCLWGqU0BsrSAO?=
 =?us-ascii?Q?/i2slutmgnPxCVk9oGsjwZO8w+Z01VzZGL8FKBJHKP9aX9N6klQcZnsS1ivQ?=
 =?us-ascii?Q?6XfCREueQoFcbe03/oaHMNy49E2FIILErj8mnpPaUilsxUGQZCWvvHvDLAph?=
 =?us-ascii?Q?l83AAWloZW/rQOYCtT6rMB6C8LZj3epLJCtH4fXdMpDV5TK6YZmf5KlJfkE8?=
 =?us-ascii?Q?Pu63lEQQTETIpvPsQDqAhj4m/ogof9lkmWjzv5cmlCW+Ct9DuW3aNduCk+4f?=
 =?us-ascii?Q?jBJK8dsPOJRjBrqOL6lQ7BvhTIeUr5E575JxfCysh4wbYoLyGlPn40dh2v/5?=
 =?us-ascii?Q?Snf3Wl5Aks3fFWaL9l1KIVFfHLyvkWqjLntrzGGB8ULRedbtVpLcxxkuNXBI?=
 =?us-ascii?Q?eOOTtL7fMPL47Iy3Xr2iF9l9XYyE7yx/x+7sVzPh72iBrYBjAvypxO7CUM78?=
 =?us-ascii?Q?Pdrri5oqJ7HOLSnrLdHBylBiEGtyeB6+CgIcNmewKJWklipvUVg1PPMJy5tS?=
 =?us-ascii?Q?FdokyytFNEQMlA0IHOJIfvK+VkU3geCnuHb/ujPuP99DNBIY5vxEiTnwfnF4?=
 =?us-ascii?Q?bujxNYin8uqlZvJZrqN9Y/0yc621vtuhc2OMKcxHcKj0WzScQBM8GghuliT5?=
 =?us-ascii?Q?oVKQukcyj3WQCGoKd9XOXq5EHdSY+pj83ymLME96ivA19Rqc5AwoG0NjTT2h?=
 =?us-ascii?Q?NhwuLN+hoMqAQ9jEtFTIkIryVlRJjW4y+yLDTq753seAnsrh3YpTWs2NjB5q?=
 =?us-ascii?Q?lqHjMxKpB0fEiMLf93sAMWnwA0jy5AfS4AFkcy9JpjoQBJ32nf16PAm+zvtW?=
 =?us-ascii?Q?xav6qJ3fBpryUZ4hwoDyjsPjDD2/Dr/jLsR8N9SXjG3HEzDCPaQSzfRTOaLv?=
 =?us-ascii?Q?lMF3Pf+963Wlw1nznZCesJ3gH4MEcuCA22RLB+TZ9+esDAAdyi/Mph7d87zF?=
 =?us-ascii?Q?CUh6m95iNxZb00k8eaosXwZZOgluKuBbzdKPADkDIOTPJ5Yc232TDAZ4+4CP?=
 =?us-ascii?Q?7BQfIF0eqDJzxFPYL62nxESCCd9U/kHILycXmXhDPRNtbQADqPQxxJ+fouWx?=
 =?us-ascii?Q?TTYPFk8IMFIT80k95f/zvxW3gJp9RDD0wAsD6BukKibcZeCAzlFnuG4pVEGd?=
 =?us-ascii?Q?i96/5OFaCYQU9ZWxRLoV84k5oxkwDzCADqvVT9s+NP3jfZ4/ArKaeCXjWKq/?=
 =?us-ascii?Q?Gc6DbVl7uy5DqQGajnNj/aYaekDob7spyj7NU1Vc17UkErp+KYBz+KaMVuNi?=
 =?us-ascii?Q?IAR0/k+2zhTYydL5yq7tBUE8cHoJVGqFrnl7sO0/c3y88+BOWlpE31VKGb7h?=
 =?us-ascii?Q?xYG/9z/ghsNp75Qf2BtgV3blCg3KuLqA1ETKTrgDF7YF2whow2jZHLQ5sgOF?=
 =?us-ascii?Q?0dfw5mkGiEtXcBUAYUCl/tSsOnEqyOzpXBOp61sfj4jO2XRm/VJC0btNiZPb?=
 =?us-ascii?Q?+kY+F2pLKmPgHxfxfgAOJEtwe3n0o5NJj6lVvhk3/E0CGg/+PA8aHh0HWRUb?=
 =?us-ascii?Q?x7lnViyZbX3R07It2aMTeQPTpDlUJZ8870Rmm6Rtl7fAMn/cl2GyDRhmhOOm?=
 =?us-ascii?Q?V+M9DLL1jTw9Cva757U4U5fzI44kNbRbHoj8du+ZorT9f2DcIsuMLtwi0JvA?=
 =?us-ascii?Q?uA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9DCAE7E328FCAD418D900701E6953FB8@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 656c55d2-6f1b-4a0f-6728-08dabc419190
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2022 19:45:02.7246
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eMWh7qHqur5OLD0M5dJSfGPUIoJ6SfWGutGuH5CI1olwE0JxGFG2e1/hQ1ncEmWqrf+lu8FquefsQQspH3oIHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4430
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-01_10,2022-11-01_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211010141
X-Proofpoint-GUID: 6P6YRLD0z1SbvaZb0lO90AV7GtPhyd6F
X-Proofpoint-ORIG-GUID: 6P6YRLD0z1SbvaZb0lO90AV7GtPhyd6F
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 1, 2022, at 10:46 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> The list_lru_add and list_lru_del functions use list_empty checks to see
> whether the object is already on the LRU. That's fine in most cases, but
> we occasionally repurpose nf_lru after unhashing. It's possible for an
> LRU removal to remove it from a different list altogether if we lose a
> race.
>=20
> Add a new NFSD_FILE_LRU flag, which indicates that the object actually
> resides on the LRU and not some other list. Use that when adding and
> removing it from the LRU instead of just relying on list_empty checks.
>=20
> Add an extra HASHED check after adding the entry to the LRU. If it's now
> clear, just remove it from the LRU again and put the reference if that
> remove is successful.
>=20
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> fs/nfsd/filecache.c | 50 ++++++++++++++++++++++++++++++---------------
> fs/nfsd/filecache.h |  1 +
> 2 files changed, 35 insertions(+), 16 deletions(-)
>=20
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index e67297ad12bf..bcea201d79c3 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -409,18 +409,22 @@ nfsd_file_check_writeback(struct nfsd_file *nf)
> static bool nfsd_file_lru_add(struct nfsd_file *nf)
> {
> 	set_bit(NFSD_FILE_REFERENCED, &nf->nf_flags);
> -	if (list_lru_add(&nfsd_file_lru, &nf->nf_lru)) {
> -		trace_nfsd_file_lru_add(nf);
> -		return true;
> +	if (!test_and_set_bit(NFSD_FILE_LRU, &nf->nf_flags)) {
> +		if (list_lru_add(&nfsd_file_lru, &nf->nf_lru)) {
> +			trace_nfsd_file_lru_add(nf);
> +			return true;
> +		}
> 	}
> 	return false;
> }
>=20
> static bool nfsd_file_lru_remove(struct nfsd_file *nf)
> {
> -	if (list_lru_del(&nfsd_file_lru, &nf->nf_lru)) {
> -		trace_nfsd_file_lru_del(nf);
> -		return true;
> +	if (test_and_clear_bit(NFSD_FILE_LRU, &nf->nf_flags)) {
> +		if (list_lru_del(&nfsd_file_lru, &nf->nf_lru)) {
> +			trace_nfsd_file_lru_del(nf);
> +			return true;
> +		}
> 	}
> 	return false;
> }
> @@ -476,21 +480,31 @@ nfsd_file_put(struct nfsd_file *nf)
> 	might_sleep();
> 	trace_nfsd_file_put(nf);
>=20
> -	/*
> -	 * The HASHED check is racy. We may end up with the occasional
> -	 * unhashed entry on the LRU, but they should get cleaned up
> -	 * like any other.
> -	 */
> 	if (test_bit(NFSD_FILE_GC, &nf->nf_flags) &&
> 	    test_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
> 		/*
> -		 * If this is the last reference (nf_ref =3D=3D 1), then transfer
> -		 * it to the LRU. If the add to the LRU fails, just put it as
> -		 * usual.
> +		 * If this is the last reference (nf_ref =3D=3D 1), then try to
> +		 * transfer it to the LRU.
> 		 */
> -		if (refcount_dec_not_one(&nf->nf_ref) || nfsd_file_lru_add(nf)) {
> -			nfsd_file_schedule_laundrette();
> +		if (refcount_dec_not_one(&nf->nf_ref))
> 			return;
> +
> +		/* Try to add it to the LRU.  If that fails, decrement. */
> +		if (nfsd_file_lru_add(nf)) {
> +			/* If it's still hashed, we're done */
> +			if (test_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
> +				nfsd_file_schedule_laundrette();
> +				return;
> +			}
> +
> +			/*
> +			 * We're racing with unhashing, so try to remove it from
> +			 * the LRU. If removal fails, then someone else already
> +			 * has our reference and we're done. If it succeeds,
> +			 * fall through to decrement.
> +			 */
> +			if (!nfsd_file_lru_remove(nf))
> +				return;
> 		}
> 	}
> 	if (refcount_dec_and_test(&nf->nf_ref))
> @@ -594,6 +608,10 @@ nfsd_file_lru_cb(struct list_head *item, struct list=
_lru_one *lru,
> 		return LRU_ROTATE;
> 	}
>=20
> +	/* Make sure we're not racing with another removal. */
> +	if (!test_and_clear_bit(NFSD_FILE_LRU, &nf->nf_flags))
> +		return LRU_SKIP;

The other return statements in nfsd_file_lru_cb have tracepoints so
that garbage collection activity can be observed. Can you add a
tracepoint for this new return as well?


> +
> 	/*
> 	 * Put the reference held on behalf of the LRU. If it wasn't the last
> 	 * one, then just remove it from the LRU and ignore it.
> diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
> index b7efb2c3ddb1..e52ab7d5a44c 100644
> --- a/fs/nfsd/filecache.h
> +++ b/fs/nfsd/filecache.h
> @@ -39,6 +39,7 @@ struct nfsd_file {
> #define NFSD_FILE_PENDING	(1)
> #define NFSD_FILE_REFERENCED	(2)
> #define NFSD_FILE_GC		(3)
> +#define NFSD_FILE_LRU		(4)	/* file is on LRU */
> 	unsigned long		nf_flags;
> 	struct inode		*nf_inode;	/* don't deref */
> 	refcount_t		nf_ref;
> --=20
> 2.38.1
>=20

--
Chuck Lever



