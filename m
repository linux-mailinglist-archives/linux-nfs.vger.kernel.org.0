Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBF0527316
	for <lists+linux-nfs@lfdr.de>; Sat, 14 May 2022 18:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234351AbiENQr3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 14 May 2022 12:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233562AbiENQr1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 14 May 2022 12:47:27 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D9B31902
        for <linux-nfs@vger.kernel.org>; Sat, 14 May 2022 09:47:26 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24EFDUbX012352;
        Sat, 14 May 2022 16:47:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=P7MLeHJoA/oGmENnSC9BP1hM7o2CMmeRwSMQyV/i5TM=;
 b=VnLNgrK/6x6H5yCyqEh9hEH9x1oZ+1/Hf7qxz8FISYOprAWCRL4U/hhhkdJBlYugkCp7
 yaUCDKPl7ujc/8JZ4pSG3OAQYrekIyRhdkSpr5TBZzF7/bT4iORsEWPkX9Upt7Pv1dqs
 QOsiyPkOhsx6Mnyq60yjQoD2JDoOhJeOnOeyxId56f77G5ZC/BwHm/XRHDAmDFoYOVhm
 osDjVSg62d/8G+7isO4ePPr5iv7xn0WbomwBs2jAWLXeP0xJrbD7t6rx/W6mCSdkFFer
 rmc9weJMvnFM+oiIDgxc8zA5Lthjfvza7uqeRsnEyCGo/YXMjJAb+2sEJguLPLnZrD50 4w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g24ytgk17-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 14 May 2022 16:47:25 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24EGfWeh029486;
        Sat, 14 May 2022 16:47:24 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2046.outbound.protection.outlook.com [104.47.51.46])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g22uyvkaj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 14 May 2022 16:47:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hx4J7IW5Y25AA1IteVyEHhnVYu8gsnB4bUpiPMeXz01NZwkljcaf328ouvQH1qvsxih+SfXLbnEYUf1AUpJai9cGTCozmmVon82G0RX4PTDtu7d2Z0Xo92+T1+tkshK7zO7u1Jv8yzxQoJOj1U+YpG9NzDsQAhRhUbpEcTIzbCdVPgLBv9vRwy4W43mTbCvH0tEOoB5PzJbqRHffs4AT0vDc7/PXQbLgdtsSzh0f29fVFQh+N5zi0T4MTBqsmgzqUplZeEeTb3lXgvw38ZKC5dw74FtW9bGYVRAAcjPSxjbhaoDuC4kMtKMKTS6y7QhmuQjsyfWK6o4JI0hwtCQJhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P7MLeHJoA/oGmENnSC9BP1hM7o2CMmeRwSMQyV/i5TM=;
 b=e0DIPzItYZrEXC3HxUSYSjbXMtCFXMoqC09ovND5sXkhgqXy5KtKQ0GyExRtWjK8/8nsQD6xeaCS0Mxw+KhA8DhuLGWkC5/v+rKcUHnqEAtx7Vnkdm+P7EDB2/uUVnd3bliWKhHhnUY0N8QBQO7qt08VvFJ1IBNE+oJT7qo7EgKjepAUq2n0H554ZbCQJdpVsjkuQgzkAdCdrlqRHqcYUoHkC04iXhTF4uA5xB/ujN0ypvusoZtlnhRD/qWk9vmn7vc4V2S1/nV9VKxMch/amrwerUxx5OhZ/ZC+xikUPbmegWS0vC2dgLhL4i6dR4doapTQhd12VK/t44v6xkxveQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P7MLeHJoA/oGmENnSC9BP1hM7o2CMmeRwSMQyV/i5TM=;
 b=IsUfAcplQwAXwyQSsUTqweGt4DQxLeAXH/dLWBcdX1QAmUJL8jzE/+3RK+7u7CB6XmbxWsQyzGvbFFA9F6egl1oIu/bxOPytoUwGpgYjrvanEkmwu1cfvzKpXeU9cUMNVQivk+tqC9l0pghsa4+/zf0iq93xagBnslgt4uzX5Fk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN6PR10MB2463.namprd10.prod.outlook.com (2603:10b6:805:46::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Sat, 14 May
 2022 16:47:21 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f%7]) with mapi id 15.20.5250.018; Sat, 14 May 2022
 16:47:21 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/1] NFSD: sleeping function called from invalid context
 at kernel/locking/rwsem.c
Thread-Topic: [PATCH 1/1] NFSD: sleeping function called from invalid context
 at kernel/locking/rwsem.c
Thread-Index: AQHYZuda/eHKjqNpSkWfuTqLChC8U60elr8A
Date:   Sat, 14 May 2022 16:47:21 +0000
Message-ID: <C29CA2A3-9D35-4C3B-8BD8-00C5D8EDF097@oracle.com>
References: <1652459676-23701-1-git-send-email-dai.ngo@oracle.com>
In-Reply-To: <1652459676-23701-1-git-send-email-dai.ngo@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 609917bb-efc9-4b01-3130-08da35c96a3f
x-ms-traffictypediagnostic: SN6PR10MB2463:EE_
x-microsoft-antispam-prvs: <SN6PR10MB2463ADA728AAEDD2F6A66C5593CD9@SN6PR10MB2463.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gBBPeG0Oh86D6vLTDjj1FydMFPUT4g+eFJfNT9Nj8Qwr/FF/JOAUCKCnFWdBz7BDSmtHx9jKcCO4DLjT8wAFAnh77KNq4XcA9S5sEhgp/wXf5jTkUzbhAjriGgL3THgiZ5FXcwm3UZJi1XxhJ/cwPHks/TcFgTMQFQyPcrZgdtNBczBAQOVMc1y7Z99JTitBTDTtzpn3OW0We6OvJSYa6mHDSMktO08SI2rM6TZ0Xb4zqdWxiBk9blKVUvunjoQ6Vx8pqHs/M7iYg0c2kEDmwVd2QtAiPcG30mfgoceTTlwvoYOyCIg8OG/HKHaJiEGjgY9R3fNZfPq2Udqvip6HdwfW4fgGX/YQZwDqPrmCmEPeF760iLnng6ChxoH+CLJgy0BZWKjhkr1wyzMvJDe7D8bUfLy+RUWLnfxu3ebEU9EUtx6rOYCE3hxJN79irKSQ8WI2XmMYMoSnVC7ZUjFy9YzY+gu8nUI290McvNtnMaReoLJNZNdgQxjWJ/L64AypjHhl1/kqOPt9TfneWOFvmsYI9eL5YS5IQRCCiIDSf6lcKdHtMOxuS46EJWtIOfBvotyJM1tEErTiLhq21fcBHPgCt1gYN2m+3gMc4wYu4/AGbSwZAE4wJx6r3f8cShDdHwcTrItoOD+971Jw0NgNd1kNBu3x7tIMDNg3ELHvL6NG7scNVm3N4EiWtrIbVe6NTsmshixSjtXTlW+1YlyAdLYktmCLCO+VHFCP0ZWZ7o8fir6M0CUQSJ09wrS4ph/b
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(6512007)(508600001)(91956017)(36756003)(54906003)(6506007)(66556008)(71200400001)(4326008)(8676002)(6862004)(2906002)(64756008)(66946007)(33656002)(66446008)(66476007)(76116006)(6636002)(83380400001)(37006003)(86362001)(6486002)(2616005)(53546011)(122000001)(38070700005)(316002)(5660300002)(38100700002)(8936002)(26005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ihn14kpMu3BIunQD3CXG9Oj3rbhrvT/tAlE/lUjHKSr+JM9dQq5GUlnEU06T?=
 =?us-ascii?Q?HjwAlVg//WWwVK5sAbrOt3lFytFdTypv3r0vf3lR7uiegsCp6hqLG3vtmvXg?=
 =?us-ascii?Q?4FMwkOAK/beB/9wEzGaKnLKTUjaGlWPloFA+4ehIQBIt5tXG4GeSuBg6sQj7?=
 =?us-ascii?Q?lGEDGe2gHohJEsTdxdzy944UVEEUPpxgJKhljmCrA9i2OdEd8xhoEuSqNtcL?=
 =?us-ascii?Q?JjHJiU9dBqpCWvCo7b6auqz1yD2rUVVYij634Ku/L6Yn3wlBHHH5IIFJsWFN?=
 =?us-ascii?Q?a2rVjoIFDP9TRdIyS8q4WoStFcMN6BxnCNEYnRuL2Yd8GXCnBIVqHT7l2gY5?=
 =?us-ascii?Q?5HwgBAcVFatgqAxbkzRJ2A+1T/Zu+h9V/wEHZZ+aiFSkFoyrdMLaXJu3M/wt?=
 =?us-ascii?Q?Ph+GzVXRQt3dViZ/9iM/vc5RW/qyJdsacrt8y71QfV4N4cFlK7FhePUAhIzE?=
 =?us-ascii?Q?aHYfb20E/ERONYATxCVAdfqR76CX3TrWVTZHLuMNHNmtI2gPb8I7hZQ4kgWM?=
 =?us-ascii?Q?zvB/XYjh/tw3zIV7TiVXNuj0SRZAolf494/SEajB4KbXDwCO5VqZD7qB1H2K?=
 =?us-ascii?Q?4Vu4xGBDqG5XPUp+d7nw8/66jq2VJBqBOjfcHB5HceGm8cB6DrGtwZ3+Zfbg?=
 =?us-ascii?Q?Gsj/PkMpACuhQgfh7i3uD6HmZVfHOJ5KcbfkUCEvMVAQwJX7iFb8QYoV8Vjd?=
 =?us-ascii?Q?RRWINCllC+oTRhuXJbf6udClDaVa+svSxQywVI45s/1DYMNBOme07iafr8nG?=
 =?us-ascii?Q?QObNjbzxksQ1m3HpqvNa6n4+PcmiWFmQM0LlVgX8BCP7m5BL/n3RQm/W6ZgD?=
 =?us-ascii?Q?Kg8P5sH5cCboBjk83CQAp64sGv/ANjH+s34xF8XH82tWR8Jvr2Un2KTdMTiX?=
 =?us-ascii?Q?C3GPk4WQL/Z+fZqBkGDxfoMqhxzkjJAIMjxpgqJKO8VoXokS4zoOsvZJ5XoI?=
 =?us-ascii?Q?1W83ZkSjZui7VgtqRjLRxrVfVHmla/sffxPq0vPqxebBQwxXBIDJ+datcvpy?=
 =?us-ascii?Q?QQiFO5ApPLheWuf6hKQbQ9AS4zZ4NorJYff0dDUjogRNoHlKqaYrHjQvfORB?=
 =?us-ascii?Q?ZIe+e58poC+g2+RPLC78wq0/zIO6bH7IxtKNzqIlu+TLYs+clYsCrVsDVNka?=
 =?us-ascii?Q?BXc+AKZ32CD1uUXRoeQZjzdROpwFdlbVgAU4JBYC3Y7O66I6h2UqDQg8zUlw?=
 =?us-ascii?Q?aGXY0fyl+Q3atYseFQ2n51ccppZYDXuldvwxzBFGElbW6fWImQ90QNArsEda?=
 =?us-ascii?Q?y0nBR68ZZ2qP1X5s1eX/EjDXsZhq7YoeuCn8OXpi4BAquFGUckQt2/6NEnAB?=
 =?us-ascii?Q?kVewwvWQPJTzDLj35m16D43b/IpKU+IDBCWxbk6n7N3fefnnlEwiSpTkzKvn?=
 =?us-ascii?Q?PP/2PSvqmlJCg4Y9q9YeIjcQR88pLfmGqLx10iZNB67oYzpfRoJljaQfyjnt?=
 =?us-ascii?Q?PlaBx3eTeqaWRFAR/L/lm+3hZHEY241iK0c3EH7PGzAeFMydsklDX8RZXwnj?=
 =?us-ascii?Q?sAkif/zyg30GrVDq5Av0kocbNHh9aZVqbZEfitVsrMGHKRyOA/2YD8jaPCIP?=
 =?us-ascii?Q?Mra3wdnQO9wZgKhGXnlRXts0WZoF7QG8rcQzwlqi50sOznvnmRSI5xiZ6Ukn?=
 =?us-ascii?Q?54NQLNUd7J1iz7z36TkBwFGMxsnamsJXahs0NcvtmFDRlvAOW8C2LRfmDG2X?=
 =?us-ascii?Q?WfQSjBlIXJNVj3kXncVAo7N4D4av/Eum/0mGEQ/j/fqUxfVpgRL3R5nGmnsR?=
 =?us-ascii?Q?J+31BfJKa0qRF+Tp6QldK2oV+M/8GwY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DB41A0A90F129E4CAB6CD4FFE48D3CC9@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 609917bb-efc9-4b01-3130-08da35c96a3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2022 16:47:21.3415
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Icz1vjo9hjksR+GyubduNNYsOak5v1hfEop3Fps7dsN1NfAJ27sib2CeMrVdfaS7neYUrS+FWvFoyTnsNsLA5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2463
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-14_02:2022-05-13,2022-05-14 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 phishscore=0 mlxscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205140089
X-Proofpoint-GUID: FRR-xlsV1zMT3a_AFbqL-Ae2j1FCbKC3
X-Proofpoint-ORIG-GUID: FRR-xlsV1zMT3a_AFbqL-Ae2j1FCbKC3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On May 13, 2022, at 12:34 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
> Problem caused by check_for_locks() calling nfsd_file_put while
> holding the cl_lock.
>=20
> Fix by moving nfsd_file_put to callers of check_for_locks().
> nfsd4_release_lockowner delays calling nfsd_file_put until after
> releasing the cl_lock.
>=20
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
> fs/nfsd/filecache.c | 13 +++++++++++++
> fs/nfsd/filecache.h |  2 ++
> fs/nfsd/nfs4state.c | 41 +++++++++++++++++++++++------------------
> 3 files changed, 38 insertions(+), 18 deletions(-)
>=20
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index 2c1b027774d4..4a8ae1e562d2 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -175,6 +175,7 @@ nfsd_file_alloc(struct inode *inode, unsigned int may=
, unsigned int hashval,
> 	if (nf) {
> 		INIT_HLIST_NODE(&nf->nf_node);
> 		INIT_LIST_HEAD(&nf->nf_lru);
> +		INIT_LIST_HEAD(&nf->nf_putfile);
> 		nf->nf_file =3D NULL;
> 		nf->nf_cred =3D get_current_cred();
> 		nf->nf_net =3D net;
> @@ -315,6 +316,18 @@ nfsd_file_put(struct nfsd_file *nf)
> 		nfsd_file_gc();
> }
>=20
> +void
> +nfsd_file_bulk_put(struct list_head *putlist)
> +{
> +	struct nfsd_file *nf;
> +
> +	while (!list_empty(putlist)) {
> +		nf =3D list_first_entry(putlist, struct nfsd_file, nf_putfile);
> +		list_del_init(&nf->nf_putfile);
> +		nfsd_file_put(nf);
> +	}
> +}
> +
> struct nfsd_file *
> nfsd_file_get(struct nfsd_file *nf)
> {
> diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
> index 435ceab27897..2d775fea431a 100644
> --- a/fs/nfsd/filecache.h
> +++ b/fs/nfsd/filecache.h
> @@ -46,6 +46,7 @@ struct nfsd_file {
> 	refcount_t		nf_ref;
> 	unsigned char		nf_may;
> 	struct nfsd_file_mark	*nf_mark;
> +	struct list_head	nf_putfile;
> };
>=20
> int nfsd_file_cache_init(void);
> @@ -54,6 +55,7 @@ void nfsd_file_cache_shutdown(void);
> int nfsd_file_cache_start_net(struct net *net);
> void nfsd_file_cache_shutdown_net(struct net *net);
> void nfsd_file_put(struct nfsd_file *nf);
> +void nfsd_file_bulk_put(struct list_head *putlist);
> struct nfsd_file *nfsd_file_get(struct nfsd_file *nf);
> void nfsd_file_close_inode_sync(struct inode *inode);
> bool nfsd_file_is_cached(struct inode *inode);
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 234e852fcdfa..1486f77541fe 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -80,7 +80,7 @@ static u64 current_sessionid =3D 1;
> #define CLOSE_STATEID(stateid)  (!memcmp((stateid), &close_stateid, sizeo=
f(stateid_t)))
>=20
> /* forward declarations */
> -static bool check_for_locks(struct nfs4_file *fp, struct nfs4_lockowner =
*lowner);
> +static bool check_for_locks(struct nfsd_file *nf, struct nfs4_lockowner =
*lowner);
> static void nfs4_free_ol_stateid(struct nfs4_stid *stid);
> void nfsd4_end_grace(struct nfsd_net *nn);
> static void _free_cpntf_state_locked(struct nfsd_net *nn, struct nfs4_cpn=
tf_state *cps);
> @@ -6139,6 +6139,7 @@ static __be32
> nfsd4_free_lock_stateid(stateid_t *stateid, struct nfs4_stid *s)
> {
> 	struct nfs4_ol_stateid *stp =3D openlockstateid(s);
> +	struct nfsd_file *nf;
> 	__be32 ret;
>=20
> 	ret =3D nfsd4_lock_ol_stateid(stp);
> @@ -6150,9 +6151,14 @@ nfsd4_free_lock_stateid(stateid_t *stateid, struct=
 nfs4_stid *s)
> 		goto out;
>=20
> 	ret =3D nfserr_locks_held;
> -	if (check_for_locks(stp->st_stid.sc_file,
> -			    lockowner(stp->st_stateowner)))
> -		goto out;
> +	nf =3D find_any_file(stp->st_stid.sc_file);
> +	if (nf) {
> +		if (check_for_locks(nf, lockowner(stp->st_stateowner))) {
> +			nfsd_file_put(nf);
> +			goto out;
> +		}
> +		nfsd_file_put(nf);
> +	}
>=20
> 	release_lock_stateid(stp);
> 	ret =3D nfs_ok;
> @@ -7266,20 +7272,13 @@ nfsd4_locku(struct svc_rqst *rqstp, struct nfsd4_=
compound_state *cstate,
>  * 	false: no locks held by lockowner
>  */
> static bool
> -check_for_locks(struct nfs4_file *fp, struct nfs4_lockowner *lowner)
> +check_for_locks(struct nfsd_file *nf, struct nfs4_lockowner *lowner)
> {
> 	struct file_lock *fl;
> 	int status =3D false;
> -	struct nfsd_file *nf =3D find_any_file(fp);
> 	struct inode *inode;
> 	struct file_lock_context *flctx;
>=20
> -	if (!nf) {
> -		/* Any valid lock stateid should have some sort of access */
> -		WARN_ON_ONCE(1);
> -		return status;
> -	}
> -
> 	inode =3D locks_inode(nf->nf_file);
> 	flctx =3D inode->i_flctx;
>=20
> @@ -7293,7 +7292,6 @@ check_for_locks(struct nfs4_file *fp, struct nfs4_l=
ockowner *lowner)
> 		}
> 		spin_unlock(&flctx->flc_lock);
> 	}
> -	nfsd_file_put(nf);
> 	return status;
> }
>=20
> @@ -7313,6 +7311,8 @@ nfsd4_release_lockowner(struct svc_rqst *rqstp,
> 	struct nfsd_net *nn =3D net_generic(SVC_NET(rqstp), nfsd_net_id);
> 	struct nfs4_client *clp;
> 	LIST_HEAD (reaplist);
> +	LIST_HEAD(putlist);
> +	struct nfsd_file *nf;
>=20
> 	dprintk("nfsd4_release_lockowner clientid: (%08x/%08x):\n",
> 		clid->cl_boot, clid->cl_id);
> @@ -7333,13 +7333,17 @@ nfsd4_release_lockowner(struct svc_rqst *rqstp,
> 		/* see if there are still any locks associated with it */
> 		lo =3D lockowner(sop);
> 		list_for_each_entry(stp, &sop->so_stateids, st_perstateowner) {
> -			if (check_for_locks(stp->st_stid.sc_file, lo)) {
> -				status =3D nfserr_locks_held;
> -				spin_unlock(&clp->cl_lock);
> -				return status;
> +			nf =3D find_any_file(stp->st_stid.sc_file);
> +			if (nf) {
> +				list_add(&nf->nf_putfile, &putlist);
> +				if (check_for_locks(nf, lo)) {
> +					status =3D nfserr_locks_held;
> +					spin_unlock(&clp->cl_lock);
> +					nfsd_file_bulk_put(&putlist);
> +					return status;
> +				}
> 			}
> 		}
> -
> 		nfs4_get_stateowner(sop);
> 		break;
> 	}
> @@ -7357,6 +7361,7 @@ nfsd4_release_lockowner(struct svc_rqst *rqstp,
> 		put_ol_stateid_locked(stp, &reaplist);
> 	}
> 	spin_unlock(&clp->cl_lock);
> +	nfsd_file_bulk_put(&putlist);
> 	free_ol_stateid_reaplist(&reaplist);
> 	remove_blocked_locks(lo);
> 	nfs4_put_stateowner(&lo->lo_owner);
> --=20
> 2.9.5

This seems like a reasonable solution to me. Still teetering on
whether it should go into 5.18-rc instead of 5.19:

- The performance regression fix merged in 18-rc3 does make the
  existing "sleeping function" problem worse, so maybe this fix
  should go into 18-rc as well?
- But it's pretty late in the 18-rc cycle, and this is a sizable
  code change.
- Greg and Sasha can take this patch in 5.18.1 quickly if it goes
  only into v5.19.


--
Chuck Lever



