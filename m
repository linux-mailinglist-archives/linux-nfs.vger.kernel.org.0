Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC16565B4F
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Jul 2022 18:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235080AbiGDQSG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 4 Jul 2022 12:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235119AbiGDQRc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 4 Jul 2022 12:17:32 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB03E12D14
        for <linux-nfs@vger.kernel.org>; Mon,  4 Jul 2022 09:17:05 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 264D1hU1001897;
        Mon, 4 Jul 2022 16:17:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=50itRb4tDgccbZlcxM9RfwLyCydXv9hv3j1j5Er3j3s=;
 b=rnQJW1AtipzB1dAOZl4gWhFGnSrHaGUt1vIBHid77guunaqmBp2k4sSd2N0C6ofKTmue
 dtwfrQDC/n19ow1ttyQyRXKJNk3k8cT2caH5uBZSrqq4yyp37U6TT8eK4cMrTfKg1yhT
 wGoyotjGcAG936GV8xRpegAi/5zL06guwJIVsfyTZVRhLXnk0JjWdqFpcwDytHrhZBV4
 j04/sM+BiBwLB0+L/0iEK1jtp1jC3x4WTH5S++pXubynIwUilnlcQA1ga2/n/LESrn4g
 Dn/IDmryQi9nirb5OAJblTB6aahipUL3WAfgLWp/+ToX91GHdzyDMlu6CAYiDDYc7OuP Iw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h2cecbumj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Jul 2022 16:17:00 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 264G5CGS020615;
        Mon, 4 Jul 2022 16:16:59 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h2cf7tm8v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Jul 2022 16:16:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GKc9iXddzCh88IkEYafXipCkLs/f3sy1EMtw4k1sKU+2fChsDYsRzgrey79UgDhZELr1Mtpjcmmnn6lb69Z4yeZXl1/rLzWFKzSW/lBMUk8z0Ri9qrWnz4sGp7ceb5aMizcLo0GNLxXA7ul5Enhgi+3KOb96TmJWBw2ZwKMvKqy/tJQBlDbX2BTobl8ZQMzlSjoU2ps66yAGnnTIz4K0VlaPqOgAh6WDCKdSoWzuEG154G+rKxI/LbrGsuRsOZ6e1mJ3g70p2ciGzjOhMaIemzL5VUBG0+uHMaDvJr08GpAPTei/r1eDcG83Y7inhnPs6cKd4bk+rXhXWVSGaEIrcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=50itRb4tDgccbZlcxM9RfwLyCydXv9hv3j1j5Er3j3s=;
 b=nXpWH84Z+ckZseuGVdkKWuOLkjFiEw/y5MoyVeYpv7DLnTDWExWVQOk7nJcfzPm3lwUMWeVrwCTASCrGUNjWjeP7OwE3kWzM756Nbd5Jj0KIqgvMcFgkE+nbd0ckZO+OtTFCLrgi+mtED+j31VeufbzrDA820hdOZmbEfJQoKBmJEuM91BboEdQ25XhSn+Deur0Ztci1izASssL1GLE4WK5DZsDf2rALe9E7vN9xxKHrehYg/EKXP456yJBj6v7DWdpaPfr13WexJrUky03g83+ddaX61GoejBgv9tFCMOgyyB77QctJvPwQallU6Dim6XBFRj9TH8j8zekGQ9XPmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=50itRb4tDgccbZlcxM9RfwLyCydXv9hv3j1j5Er3j3s=;
 b=KSlJEY56b0e58ktnniD0xBVFT63Y0ueWo9G7h5N0BnPvnHR1r0H41qkcEt2yv6GsRlcYUkUuSOAizceHyHal6DWKTVdvbO0jAaekHMnlyO66Sp7g54M7JIiOzxiEh2CH1zY5NZ6pzcgGyb2KY3iqOiuyldSlX9kdLkWHWa10Kco=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN8PR10MB3459.namprd10.prod.outlook.com (2603:10b6:408:b1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Mon, 4 Jul
 2022 16:16:58 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703%5]) with mapi id 15.20.5395.020; Mon, 4 Jul 2022
 16:16:58 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Zorro Lang <zlang@redhat.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Bruce Fields <bfields@fieldses.org>
Subject: Re: [PATCH v2] SUNRPC: Fix READ_PLUS crasher
Thread-Topic: [PATCH v2] SUNRPC: Fix READ_PLUS crasher
Thread-Index: AQHYjMLF3XxMjMXp40+0TpjOlgRuaa1tzJaAgACc24A=
Date:   Mon, 4 Jul 2022 16:16:58 +0000
Message-ID: <0E657811-774F-474F-BA33-869F421A0874@oracle.com>
References: <165662209842.1459.4593520026847863736.stgit@klimt.1015granger.net>
 <20220704065533.pfpvpn7ihxs7vagf@zlang-mailbox>
In-Reply-To: <20220704065533.pfpvpn7ihxs7vagf@zlang-mailbox>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 49bcb6b5-3b3a-4b0c-3738-08da5dd89ea7
x-ms-traffictypediagnostic: BN8PR10MB3459:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 42PLM8qMX5PKGijFFE/GrhB23ap/a/CPhp7Ydro10OUrZm3u5C3YuL95UBW3Cww4Mg6+yzcp+RAGrUi3nCKjtWkXz1rF6yVo+h+LRzfIL3gt4xTvuWFwJQ+fj/Dx1jnM3BwfyDImSAhJo6ZMx5bOcI70Sdm4SOA1d/FvbvVRXOFfQCPjYo3LBe04mfo24BCC88/63Dsoihk3crKDuNDj6BSGGj2u/3R/4NP8zWL63YQw6AKJFMt9Ssqu0ULC528Xw9vLQcDaZSlbD8kZruII0g2s1iY3EUyGBG0Ini164z8gCRoBPG13vABBUMEgllya9r6fVpG6cn9Ru3omOEv8gl44w/vdahtfWMorNIKj203H2zTvWUg23pcbiQ6gB5ZqoJ+mdvM+r9k48J4fAlZAJYUgaray2ww6dfgJ+rsll3+pFP2Gy8xaXHN5PJgVY4mIrKtWYa0TBrxYJVxysFhGakpStfRexa/oxTFgzcKbTECdk3wLtZ19K4E98qZ0oiG5A82HU+aRT4WBB9LG9HFrqgABE9eu+3b0IQX+nu7+4uvXrZYMBL3J4ewYYv8PUhYAsyWHzB6phJiMv5CYguFANpVw+/V3YhdqAzaLqkV4bChdlMr5B92kvEjeRY0PS1g8gJb2T80yx7VVhcJIC3rDKqF3GvYPal+WjiCDEi6TSSyxsaB+E7tPm2XWsDbPqhw1FVepk3BvPP6cql5WeiedbhCi6fyC0hV+3ygigRwP6BScqZetMxNoCzRI35Mmwjy8IxvYrn7JhdGaXegRrPzkDFzBAN6vf+FCS1jFYA5p0j6m8g5bwk6vAET7Kzhx0xxf0tAhDgCBcxBrP8LsQq5h1SpT2zT1/r9scNTUK6SKUibh+tJEzDCEFNkJ4ksCWMgOWSF5cH/x/6pnhplreswUZdMSZcEEukiiMy1J1wYoRGW/HVXsfKUhSwSsp94qhUf8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(376002)(39860400002)(346002)(396003)(478600001)(5660300002)(76116006)(66946007)(54906003)(8936002)(6916009)(122000001)(38070700005)(316002)(33656002)(86362001)(64756008)(66446008)(66556008)(6486002)(91956017)(71200400001)(66476007)(966005)(4326008)(8676002)(83380400001)(2616005)(186003)(53546011)(26005)(6512007)(38100700002)(6506007)(41300700001)(2906002)(36756003)(21314003)(45980500001)(473944003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?p9fZzHbBgYiq0bGCTnQX5KRCdi3BlujdQex8NPVxYqV7DR8LBFBfJmmRf1he?=
 =?us-ascii?Q?GA9ySRgRaHvT1+RsEi05AjOW9hIua2bB6P/kHlnXAkjjIbezpRYiE2CE4iGV?=
 =?us-ascii?Q?flJ0EAYccSOlsXJ+nQVb7246UDCDVImN6Dy0I0NqUISNxwIJNWFcJbSpWN2Y?=
 =?us-ascii?Q?Kq4pxfTc3xLtxrfr4zyaWmYb5tDnXzDoIYpn7XuCXprpV3uJaaWK9Uox8FT6?=
 =?us-ascii?Q?2h/nNAM3YBxA1Z0/DoHyFQyg+wlhbWFukLXSV551F3VfFr/9FJ+SxFJ495CM?=
 =?us-ascii?Q?aWcpMiCSl2FE8oqYcOZ39AFx8KUybQfYv+Ghhqt9pV3K/+GrVqj0a+fna/sf?=
 =?us-ascii?Q?Q7fh+mCTDHRpBizxcwTQ1Xn7Jc/Hht37EQuGim9Ee4KrmyHvU4wKdiG8AFnY?=
 =?us-ascii?Q?kR2cttDylf811G/EUxcH0JsIl/nqfKQvbCVQ3QBXLdYAqO7Iu2t4Brp25kDT?=
 =?us-ascii?Q?r2ZI0Hsn/hzdGptvFa3mQe7q64Tz89vR8q6BOn2u/qsVe+8NmJB6K6S3zApt?=
 =?us-ascii?Q?2CfPJwZ06uMgd9ccjWotlSHe2SrEv6luHHSHTH42VNFD73rRadN8yjHkQYAd?=
 =?us-ascii?Q?WqIKmtkn4cpfbmLD2znZJCKSAmunFg2UgQHZBkpQxnPBu4N38dx00b0bMGxk?=
 =?us-ascii?Q?08PnzquHlS1yW8sLN3dhGNG1otvYLJ7MtiYCRHqRP47dMIo7rDEQixTjbROf?=
 =?us-ascii?Q?egJogvg25TkcDAAgOa4/aJXNgqOigZFaVbGzOl3s22WsFhihxkIzwX2Nojyu?=
 =?us-ascii?Q?+BcEbNfFkRDDuHEOC+7U+Ngc1k/gH4AVvfK6VFtWsqxiBK3LEfnen5Vm8hvr?=
 =?us-ascii?Q?p+sjqiv3OhC3ZAfPj9TJTXvidd6xTobphofNBxTv2Xmr8awXZ/gUb5sQoKAW?=
 =?us-ascii?Q?VVaqnCvYgNkONRD+7ERhBKWLJX5OCVmjL8Re7vKwArksmqGR11C1R8du/dRI?=
 =?us-ascii?Q?g/5FqE5pRo3Kyr5lswH4OzbvFr9tqrb2Hrraftd6o5mrwrPySMmBvxrJkoNB?=
 =?us-ascii?Q?4Rqzc2eByMf2IlALLKTW4nmkDNyvL94MqBJ3oa32TBgXFw4JYm37/Xd+83IB?=
 =?us-ascii?Q?Usbqq6PVV3xqod2ZZg0yGi15bA9BkYTK4zEzI1eQSq7A2qa0pjdy6RPYzstS?=
 =?us-ascii?Q?iIa8U+wku2LbPjQBbiQopLQUwk7Ci82WUG9M0D3LSOg3/4Rn/Pvy8dKYjIU4?=
 =?us-ascii?Q?AvU+jlHfygTOL6Vb3aEC3ldG3FXam9AfDB10+fj2HjW1PtNAlnE9Y+2X/s2+?=
 =?us-ascii?Q?kklWUFw7ftagqjeA3QPkDkM4yn9YyYoM33nM23trNyweFEptVvkFhv3Kvcz5?=
 =?us-ascii?Q?J85c4it0yv1dR8YaJxBZQ8T5ERcSzftn+SGiBJJF8xDoaw3wdPSfXPYIeZkL?=
 =?us-ascii?Q?ta2mhxmnAhik+3PXDe2LSUG9ZjEwVGwrG5qFHg/CiqKKHDyaaTooVB0VL4rQ?=
 =?us-ascii?Q?NkzNjjgY2vez+RY2Wui/7Eo1H9Mk+VQiErLBaBgdREZJ6exnd7c3QLabhmUX?=
 =?us-ascii?Q?JchdY6xyWfBO/LWH0AA2BwQ+l1hB82xt2/TWXJXoEhfUwdnIoA+dwN93Ecuz?=
 =?us-ascii?Q?E9/AwJxG9W03ZOi7M7OkKc+BLvBfm1H5NcwFN9gkjsaOnktx+1gbI0HGDVnw?=
 =?us-ascii?Q?pg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <566F514A4BC4E8439100B967547E6E42@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49bcb6b5-3b3a-4b0c-3738-08da5dd89ea7
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2022 16:16:58.2111
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v0wpTicWyckfmETynyFcEw6i1vbfqACHyNByj+uB7K0HBf0GbacXKpdsJJ0q+p8KpZwJMSG8dgF21/lt2t+Llw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3459
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-04_16:2022-06-28,2022-07-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 spamscore=0 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2207040070
X-Proofpoint-GUID: BBFr39s1ndWjuW-hQfsjm_xgRjkMTYh5
X-Proofpoint-ORIG-GUID: BBFr39s1ndWjuW-hQfsjm_xgRjkMTYh5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 4, 2022, at 2:55 AM, Zorro Lang <zlang@redhat.com> wrote:
>=20
> On Thu, Jun 30, 2022 at 04:48:18PM -0400, Chuck Lever wrote:
>> Looks like there are still cases when "space_left - frag1bytes" can
>> legitimately exceed PAGE_SIZE. Ensure that xdr->end always remains
>> within the current encode buffer.
>>=20
>> Reported-by: Bruce Fields <bfields@fieldses.org>
>> Reported-by: Zorro Lang <zlang@redhat.com>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D216151
>> Fixes: 6c254bf3b637 ("SUNRPC: Fix the calculation of xdr->end in xdr_get=
_next_encode_buffer()")
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>=20
> I can't reproduce this bug by merging this patch:
>=20
> FSTYP         -- nfs
> PLATFORM      -- Linux/x86_64 ibm-xxxxx-08 5.19.0-rc4+ #1 SMP PREEMPT_DYN=
AMIC Sat Jul 2 09:59:50 EDT 2022
> MKFS_OPTIONS  -- ibm-xxxxx-xx.xxx.xxx.xxx.xxxxxx.com:/mnt/xfstests/scratc=
h/nfs-server
> MOUNT_OPTIONS -- -o vers=3D4.2 -o context=3Dsystem_u:object_r:root_t:s0 i=
bm-x3650m4-08.rhts.eng.pek2.redhat.com:/mnt/xfstests/scratch/nfs-server /mn=
t/xfstests/scratch/nfs-client
>=20
> generic/465        12s
> Ran: generic/465
> Passed all 1 tests

Thanks for testing!


>> net/sunrpc/xdr.c |    2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
>> index f87a2d8f23a7..5d2b3e6979fb 100644
>> --- a/net/sunrpc/xdr.c
>> +++ b/net/sunrpc/xdr.c
>> @@ -984,7 +984,7 @@ static noinline __be32 *xdr_get_next_encode_buffer(s=
truct xdr_stream *xdr,
>> 	p =3D page_address(*xdr->page_ptr);
>> 	xdr->p =3D p + frag2bytes;
>> 	space_left =3D xdr->buf->buflen - xdr->buf->len;
>> -	if (space_left - nbytes >=3D PAGE_SIZE)
>> +	if (space_left - frag1bytes >=3D PAGE_SIZE)
>> 		xdr->end =3D p + PAGE_SIZE;
>> 	else
>> 		xdr->end =3D p + space_left - frag1bytes;
>>=20
>>=20
>=20

--
Chuck Lever



