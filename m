Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D240611B01
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Oct 2022 21:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiJ1TlQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Oct 2022 15:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiJ1TlO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 28 Oct 2022 15:41:14 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D168C876A9
        for <linux-nfs@vger.kernel.org>; Fri, 28 Oct 2022 12:41:12 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29SIxDOH030023;
        Fri, 28 Oct 2022 19:41:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=H/Q8v8P6GST6KkVX0knwTSTGlsqVo7UbqTCkC3bQq+M=;
 b=IPZ8+V1VIz0Xto8UaD9pRLmGPNARCGItzFRt9cJykPyLbS0cjjHUTjg3tJirmSvc/v8L
 PbwfjdJWHiO1e1ZuSaUkaL7aZty4v9geq+iCaybzXjhPQn7NPa9lIXLtdsDZ0nddC8IY
 4cWEkMxYMOAAu/AXTEZkvpeRKsidJcbgoeWjhZMWhPRpojCMZk9WcTW5EAC0leABitK3
 zqFlEd2HCEJOPqQ/MPRMCUjCDS77BHKO57iYEm+yrz4xj0LJiofEC9gI0cPibmLzL2G0
 ZKLFK2oVI4dVx5c6z/P/VoxyPKOoalCeStG57Zl/rN2GUalBUWCTkhHnQ7aLbO7jwXON 6Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kfagv64c6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 19:41:03 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29SHxqsY012294;
        Fri, 28 Oct 2022 19:41:03 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kfagsdb8d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 19:41:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AUSpz+PpgIj+uktGYrRdg1d4S30c6duPfQ5bpINRERjKOBYY6GS5L2ilsOaHdKJtpeO74aSOIYYB/Htt7nfU6sft2wm4VipOI4iEn0gMlxgmZorBS4hzAuEAyK6c44PJr0UM9nVKLHTDWJmhQZQKfw1/KC/5XNyZnrpC1JyHu+fKcPAe5RQG9ldyweU1cSWC4nIDy3uv1w8RnRIPDE/iGhmxKtBkst7UprgzgnHdjGdRCIueVAsQwiTXxKSh4BO4GjWj0WQcgmMcJzsd84l7lagAGahy4hC6qI7ZKtO2Msvr2LJq39194450F+kaWfHcT0y2YxfPb8Um9E+9qqadhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H/Q8v8P6GST6KkVX0knwTSTGlsqVo7UbqTCkC3bQq+M=;
 b=cBDKjMnSX/EBSVwgjW3xk6yol8bMvCDnyubOCISZDuszfm9p/G9y7vJI6aCxWGy7Q+fonu1k6FEJ4/2xqERY47b+rlnH33QWtSIq1+xB6U7Mt4LcmBAKyQRQLTtzIN5NEAc3HUbZVEeApTPOaXuSmZH0KTmW9aWEsDe9mVKyRtLkYiRy97QBbVfK24+WDyUwzL1zf0+fe3pjrmp7t+SrHMoqWvx1CO4adzuNzEMO6RaryzkbQmUpm3EhxdL8dahodcvlYCvPKN87RZ0OFWzm793JAiUEhXHxJZmZoU+Yqqj1pV1wISCu8ONsd7SZnmGt2yVWKR19ZBFYbUOyuwoxJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H/Q8v8P6GST6KkVX0knwTSTGlsqVo7UbqTCkC3bQq+M=;
 b=Z5/AUDw7bDmJ0bPGxqgVohd1aJCF3cnI6wl0iTQwl4xyR5LnamjPiqBMKjkqdP+34W0Vikcuh7Ox56PBRj7JJHeLd4XW4+8d+KeTilgzE/7fSu/nkN8CDz8xfAviosmnmygCpj6WdSOKAAGxLhkpdYrdGAQXJ2fqLtl7tM/yooM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN0PR10MB6005.namprd10.prod.outlook.com (2603:10b6:208:3cb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Fri, 28 Oct
 2022 19:41:01 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%3]) with mapi id 15.20.5746.021; Fri, 28 Oct 2022
 19:41:01 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Neil Brown <neilb@suse.de>
Subject: Re: [PATCH v3 1/4] nfsd: remove the pages_flushed statistic from
 filecache
Thread-Topic: [PATCH v3 1/4] nfsd: remove the pages_flushed statistic from
 filecache
Thread-Index: AQHY6v8bB16g4C3tmkCl+UsoZ0akuq4kNGsA
Date:   Fri, 28 Oct 2022 19:41:01 +0000
Message-ID: <14EFB870-5222-43B7-ACB4-E249190C7EE2@oracle.com>
References: <20221028185712.79863-1-jlayton@kernel.org>
 <20221028185712.79863-2-jlayton@kernel.org>
In-Reply-To: <20221028185712.79863-2-jlayton@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|MN0PR10MB6005:EE_
x-ms-office365-filtering-correlation-id: b22839c8-b77d-4a83-16e6-08dab91c5826
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MsaVxEPDZggeiZNdMTSd1obA0+gl7ylBB3k9APFEA7rokQ3ee+/djns7vJSEVaRVUAG5braMrY0LiZcK7ZIYp8w68o7F0CctWLKcZccqZbXtjw6xClXVvVyhmeD5ZLytnncsKELgc3O3slOJBqa3Dqyos72Qpd8oMT16Yr7aJ4fSxbeN6yZFJEA+k5hzPcubMd9U+eu6yWfC6q6ddqdeWw1gM47Ovy+h8Gz0WhPEF9fbWn2F6SZuP4hnscIipA0FoqnlTUUHpNwNuL4DF4KmKAJp18w1v0Zs5d1AzTxZ3U/z0AhRHPF+IwVct0SLIbyV3hhRaWmIwGK0q2cb+wRX/K0s/Ct9qzu9ElTPkni/1qhth0I5i7GcYqxzk0xcoC4roYhkxKyCi8DImH1zXylwa9T1OCQDRxQThrPFNs4uhjG7XLL3fLU4FeyRaUibCsyPT5T/PTNNGCA4fjou1CIxnm82MYx4dxhgdr3QCFYdhoeEQWD3AnFjyjxBIV/stEOSqxAcHgvl5ZItc0RBO4aui7AsLC3qLe436C7IIpfMyg72C2PNQYFgWarU9SBkwbJiic2RndJMs6ZrobD0CiB1JGHGN5KTZX7ijJ4UernlkY67bqjUAe9Xd/2LPsDz+0+V6oul6pRopBdZrpDPULSA+55sIc1Aw+KvT//Vc5p0LF6XUIXyydaVTt1XGGIqh43oKlp9zaVUZhFkwiTAae41UaObVtpGyY+1T8kuJL7Yw7sY5KXiuYvYQ1ndD/iKNd6s699UyordaJ9WHNcwtuebgzksYtg/sKefRMCjwWpyDvU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(346002)(39860400002)(366004)(136003)(451199015)(45080400002)(83380400001)(86362001)(38070700005)(33656002)(38100700002)(122000001)(2906002)(5660300002)(26005)(64756008)(66946007)(8676002)(4326008)(66556008)(66476007)(66446008)(41300700001)(76116006)(6506007)(6916009)(8936002)(2616005)(186003)(6512007)(91956017)(316002)(54906003)(53546011)(6486002)(71200400001)(478600001)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?C1OQVyyVJe7wbWYPGkwede1nNZ8BXGYIIE7KaT2DblE1o/FyaEjtvXHSbe2T?=
 =?us-ascii?Q?d+Z44Z3tpYxOG5/ojjVVc5Fbj9zzUwi6mqgwsJc6fz5AyUHOgIoNGOh6eg2T?=
 =?us-ascii?Q?m1fBzMheVJeelUQenxW2uCLCBK4tWy4+MaCWTVHs/yHQ3PTsVuT15DNaMq9p?=
 =?us-ascii?Q?Cx0aFo2FUIp0RicRp5mJqMXm0DET8eVyIxCHw6D8bOkoxFvUYbG5zIbvlXQJ?=
 =?us-ascii?Q?fmocmF/IXqjvwb4pzCeloiFsvaLppWryP6mzH4q6KR9lpCfhaNvuJpGgnX00?=
 =?us-ascii?Q?HjI8eivwDjxuvn2gsdZC7AbAQec2LBGUD0x2rwumdbMI3126o5EqZKlUxOlw?=
 =?us-ascii?Q?m3wwb2/nZSjA5Hzk8kpGmQ/Equiz2NOg1AXshsTXSDtjWLtnSU3KkSkK+gAa?=
 =?us-ascii?Q?HrYG+WHkLmda+W0VqrUaFJG2AsfIXIeXVguZDi4+GLbfgge546a6/OPmJOm9?=
 =?us-ascii?Q?px6UyGqPcAHU2QtFyqRP1RWHrbVASkJk1GJZdn7marikXniuHHYGJAFVIEzv?=
 =?us-ascii?Q?73Knt9/Zwb9rnidmUSwf1j8bNXrhGxpShQsHkwEudPvTwQzAxGNn7DpIbeMc?=
 =?us-ascii?Q?DAYEkzGkvMD/U7hqSZUrHIuJiDnMjvluvltenxSLYM02/wi2sx/4noT7Nynd?=
 =?us-ascii?Q?hw0Hphzk6MfBJpOsrbXJ7crdEKqBGSkeTttQzUn2dMOMsHEVb9OxAmFyRS4K?=
 =?us-ascii?Q?gNHfJ4P5iECuBDknL6eMlYTZyNxRnQVN0gbsYzPcrlOt2hvgb/W3DHB8BrKQ?=
 =?us-ascii?Q?5MBpMelY224d+63RaKMYayENaOe5FhUUyXJHxVroXgLToRvX89+ZhAkyTU39?=
 =?us-ascii?Q?WkIq9S3mC7VIRGLL+0j64Qcd3/icg8PgGQDjBCznk6g+XvpKDaq5jIXLvyh2?=
 =?us-ascii?Q?28jPNn7W/345hYbJnVZdnALKB9PtakVOQQLBL/kItQgPFNGs9dnRE79A848c?=
 =?us-ascii?Q?8unneacD0MBiKnl+f2cinaLz8ycNVZGgE5+muf+VuMon7mH04F0zFD4otxtG?=
 =?us-ascii?Q?ESax+ADQoSkkWVzU12gFOFhET/RsRj2fbPWuCkMs6zE7hg4tYQs1H1E5L2tC?=
 =?us-ascii?Q?ttU+851bMvs6BopwM64RwBb5Vlj3KDbnlFz3mIzKhHuS8bSnBt04UkJqLTkn?=
 =?us-ascii?Q?o+E63qDgUc0ZAcxJO0AomedI++1XSsNfZVl6UEjYFLmNDkDem7nuN98acaM6?=
 =?us-ascii?Q?jRDhzQikZj93GEVOg0RT1btHsb8mFFNlVER2QlubifmbYzW/Cp0Fu6vRQcgV?=
 =?us-ascii?Q?TTnjr5GYNQewxRBNT7jPkSaRjofWxN1fZsY6aeYopXttxEo9xiSJOHaHsPOd?=
 =?us-ascii?Q?uDUvH0tbwEfvBGETZsH5UN5GuUL44Y4grO8jGIrg8RnLfhVo4OOHThIwVH9L?=
 =?us-ascii?Q?oM0M7tRoBRV9xxLG0fk8KJS/+OFjJ5zGuW9oQ3KSooknOF09fZFQ3UeqteEe?=
 =?us-ascii?Q?2r4YWUIwPSo2NUlZzhRJeSupgvhJm9kobIqzrLtcqeAHxLX/BgbppDOBbbij?=
 =?us-ascii?Q?peQWczzcxRIE5Quu0hkLNs9T4P9zNGi9WaUE6m8wFZ+ueVXFEJ82SSczAkV9?=
 =?us-ascii?Q?NagBeNErX3vo0g9OVUQSZcNDlliIuxj2L5Hb/td2050GvWZOEtRi97yIU6Xy?=
 =?us-ascii?Q?EA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <87DFE4556CDF1F4088BC81CBB151ECF0@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b22839c8-b77d-4a83-16e6-08dab91c5826
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2022 19:41:01.4828
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5qcLzdSKYcSd0bL54IV7GauWXjEWr1sSLpiqysffpxL1PE+AJIIY2LukHtuSOgPJlBOcDZsZnNvS+iCpkPv7Wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB6005
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-28_10,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 malwarescore=0 mlxscore=0 suspectscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210280123
X-Proofpoint-ORIG-GUID: 7ZVNkGIIRN5zxZ9YOGSj4VysEyOyKC9_
X-Proofpoint-GUID: 7ZVNkGIIRN5zxZ9YOGSj4VysEyOyKC9_
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 28, 2022, at 2:57 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> We're counting mapping->nrpages, but not all of those are necessarily
> dirty. We don't really have a simple way to count just the dirty pages,
> so just remove this stat since it's not accurate.

OK. I'll apply this one when the others are ready, so just leave it
in this series when you re-post.


> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> fs/nfsd/filecache.c | 7 +------
> 1 file changed, 1 insertion(+), 6 deletions(-)
>=20
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index 98c6b5f51bc8..f8ebbf7daa18 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -32,7 +32,6 @@ static DEFINE_PER_CPU(unsigned long, nfsd_file_cache_hi=
ts);
> static DEFINE_PER_CPU(unsigned long, nfsd_file_acquisitions);
> static DEFINE_PER_CPU(unsigned long, nfsd_file_releases);
> static DEFINE_PER_CPU(unsigned long, nfsd_file_total_age);
> -static DEFINE_PER_CPU(unsigned long, nfsd_file_pages_flushed);
> static DEFINE_PER_CPU(unsigned long, nfsd_file_evictions);
>=20
> struct nfsd_fcache_disposal {
> @@ -370,7 +369,6 @@ nfsd_file_flush(struct nfsd_file *nf)
>=20
> 	if (!file || !(file->f_mode & FMODE_WRITE))
> 		return;
> -	this_cpu_add(nfsd_file_pages_flushed, file->f_mapping->nrpages);
> 	if (vfs_fsync(file, 1) !=3D 0)
> 		nfsd_reset_write_verifier(net_generic(nf->nf_net, nfsd_net_id));
> }
> @@ -998,7 +996,6 @@ nfsd_file_cache_shutdown(void)
> 		per_cpu(nfsd_file_acquisitions, i) =3D 0;
> 		per_cpu(nfsd_file_releases, i) =3D 0;
> 		per_cpu(nfsd_file_total_age, i) =3D 0;
> -		per_cpu(nfsd_file_pages_flushed, i) =3D 0;
> 		per_cpu(nfsd_file_evictions, i) =3D 0;
> 	}
> }
> @@ -1212,7 +1209,7 @@ nfsd_file_create(struct svc_rqst *rqstp, struct svc=
_fh *fhp,
>  */
> int nfsd_file_cache_stats_show(struct seq_file *m, void *v)
> {
> -	unsigned long releases =3D 0, pages_flushed =3D 0, evictions =3D 0;
> +	unsigned long releases =3D 0, evictions =3D 0;
> 	unsigned long hits =3D 0, acquisitions =3D 0;
> 	unsigned int i, count =3D 0, buckets =3D 0;
> 	unsigned long lru =3D 0, total_age =3D 0;
> @@ -1240,7 +1237,6 @@ int nfsd_file_cache_stats_show(struct seq_file *m, =
void *v)
> 		releases +=3D per_cpu(nfsd_file_releases, i);
> 		total_age +=3D per_cpu(nfsd_file_total_age, i);
> 		evictions +=3D per_cpu(nfsd_file_evictions, i);
> -		pages_flushed +=3D per_cpu(nfsd_file_pages_flushed, i);
> 	}
>=20
> 	seq_printf(m, "total entries: %u\n", count);
> @@ -1254,6 +1250,5 @@ int nfsd_file_cache_stats_show(struct seq_file *m, =
void *v)
> 		seq_printf(m, "mean age (ms): %ld\n", total_age / releases);
> 	else
> 		seq_printf(m, "mean age (ms): -\n");
> -	seq_printf(m, "pages flushed: %lu\n", pages_flushed);
> 	return 0;
> }
> --=20
> 2.37.3
>=20

--
Chuck Lever



