Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AAA57619BB
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jul 2023 15:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjGYNVe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 Jul 2023 09:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjGYNVd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 25 Jul 2023 09:21:33 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14DE010E5;
        Tue, 25 Jul 2023 06:21:31 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36P7oWN5015883;
        Tue, 25 Jul 2023 13:21:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=HssEXGp+HSPbq/r8kgEUQsmyVJ90hI/MsbdK7a+K1pk=;
 b=nKzHSrmBroFnIcyhfgGmHDODMroFY6THTjeC8nh+u5FonJkolXkCCEX37CIXZsyAluiF
 oeZ6GZIXBXBd7z24bn9s/WGDSUlEuo520mXYTEWC9HSAHRhUy/yhS7J2JFLxtXpYgZSV
 srMf3uKYnv2lGuoawMfIk0pkOv0nvTAjqg5wpNPreGKQRXV+W4giwx9DLw6GfMN7HlCp
 2CMNQPfAX6iXz0MWodFIJurrG12BGCANgeZPf5wHjZmYZFA06T16zDd2lNhckTo9EYcC
 WsEo6X8mkDOEtDsWWgnVNCWk0k3Y0eovxgUEsQ94NndWS4i3VVVAkvhUm32lq5sU/P+3 IA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s06qtw0ba-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jul 2023 13:21:17 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36PCJamF037141;
        Tue, 25 Jul 2023 13:21:16 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j4rp0n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jul 2023 13:21:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nyVpSXZygqQEp68QjNrNCD2Kp9hi2tjNRTJDd4hJvWQRv3oye1R4niV3L8s5fPjx9CQVWeEuVgoeP6naDFDs8B7fPNfh7VvGb9dnjR4IfAr+CuqBHctd9WKdngcQGNX7zHhHKQUH9ol8478mVvZWxi2NkS+Jatg7AETzSMwWA9ylvCQm/BjsNGtbEkVI4ewx4mGLWk6qWclpZJHqpWko776Op0RpZagws1dixEbbWJVT6O5WLgtTXAYEpUwGdF49Vo9H65egf9W9GuV8ymbByLlDsBDtG0DRN71cQZIJsyxJFGb1X1gSU0syF3iBEIQQ5mH7ellG8k3emUSKDl+urg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HssEXGp+HSPbq/r8kgEUQsmyVJ90hI/MsbdK7a+K1pk=;
 b=k0zwzQVmYQmUs54RyVhgkhgQW6E/6zwp6HqBZorAPzBW8MbWci2XFjqpOIeFtr00LVCuJWuej94AN+0xR5IF4xMhtw6c7RLdm6YPGzv3hqz/9wiXtSb0tyji0fY4qABaBe/7ni0rwuOxLqvLhmVVc+++QTou/iG1RaIotPZyAOGUey31L7bM9ltE41tE4hAvGoepSFZVE7bxkzJkp2PZyfHvaqcCcvQOCAZ5u+4dnlrHypNxLb/Fr9hSAyCvYKjVar9hauCaTC8HIPmzTC7CFNpvmPybsLjzlzd97RGDZZ5JhdZkDBqSpfgrKjRktWxRYy+d0qOn/qeuHefc4z3hzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HssEXGp+HSPbq/r8kgEUQsmyVJ90hI/MsbdK7a+K1pk=;
 b=g0aWPdfChBqyv8QEheQtkJYGDQoAMJElS+hQ1cIW8gd0laqHdaN0HQDATgXskZ1bURtM8DoZc1Y9+zBnq4dEzWoR9wyL5pD/i4UvAgxFIz4c3+58DzhTt08QWUOKNIAeAiAamsxyA1vKctjTZzU24zFSACNTvVLEmF6d7GQjeCM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN4PR10MB5589.namprd10.prod.outlook.com (2603:10b6:806:204::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Tue, 25 Jul
 2023 13:21:14 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 13:21:14 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Linux regressions mailing list <regressions@lists.linux.dev>
CC:     Chengming Zhou <chengming.zhou@linux.dev>,
        Christoph Hellwig <hch@lst.de>,
        "ross.lagerwall@citrix.com" <ross.lagerwall@citrix.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Chuck Lever <cel@kernel.org>
Subject: Re: NFS workload leaves nfsd threads in D state
Thread-Topic: NFS workload leaves nfsd threads in D state
Thread-Index: AQHZscpE2u3hRnymrkaAkGCGMx38d6+ypIIAgABnPoCAABH/AIAAJpqAgAADUYCAATOkgIABit2AgAAgGoCAFDMbgIAAOMOA
Date:   Tue, 25 Jul 2023 13:21:14 +0000
Message-ID: <73D6DC23-297A-4802-9925-1C94BB14FFF8@oracle.com>
References: <7A57C7AE-A51A-4254-888B-FE15CA21F9E9@oracle.com>
 <20230710075634.GA30120@lst.de>
 <3F16A14B-F854-41CC-A3CA-87C7946FC277@oracle.com>
 <F610D6B3-876F-4E5D-A3C4-A30F1B81D9B5@oracle.com>
 <20230710172839.GA7190@lst.de>
 <0F9A70B1-C6AE-4A8B-8A4B-8DC9ADED73AB@oracle.com>
 <20230711120137.GA27050@lst.de>
 <82cb9937-bd11-64a9-2520-bf3cf81ec720@linux.dev>
 <92CC9151-0309-41E9-920E-A549E2A73BE4@oracle.com>
 <5ce5b89e-3ea7-318a-1234-279ec92ffb8b@leemhuis.info>
In-Reply-To: <5ce5b89e-3ea7-318a-1234-279ec92ffb8b@leemhuis.info>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SN4PR10MB5589:EE_
x-ms-office365-filtering-correlation-id: 44feccf3-6fd1-4203-13bc-08db8d120583
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UTK95eUWzv3Jo9NhONKncSCboBPDLXz2CZCxmS8NTvdveY0nZir4xN44nupOQrun010kU8ooX3K6Edqgy02ECsx9/2FVi24zlld2DjiA1ELuWxSoxxfYM6I6eHR8kBlaqbirQ2kvKbnA10QpeGHLU7uZ84Gxor6l0ymlSfIfmsQPUktfqZ74/CMwhWw0pZ/XMyXwWRcoSOAQuutLiXgSUTfCTaPEo6ucDwtCYYZmYO76C2yzxt6WYPAZP2iN4h0tCY38l52p+Us82wrWBkgVKlxOHFT3gybw4J5pby8LP5UtR+41fBRgkRvPy723/F6huF1VRsRCDgpkOv2BfXeNQBMOwW+Q78I2OQpohdPMN8AaAKnEUcFaVljBjqHrwsTsdls0jcfllqHgUJjQINqHXDqXNVPlK+B6eFyeGInStAXrfrEA6IAd5TKTnBFabj0bqr9ziY7qiU3IVhKo8TztBhlojmtF4f43EjBh72PfUs2uHq0aTLrKOUqPuTJVWIGkQx0KKs38tY0r/WEbKSBj9B5dY0LoGLnKjaVk/8vZmvAusoJLih3vq1fbt+8ge8PWR+4tVStLy+ffRKChGz2EWedI+cQ+W665znZW+ykYgZUSFU96qrZFIkwQnHvSR2jiSOQwZFHl77OXWb0l7mXhIA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(366004)(346002)(396003)(136003)(451199021)(53546011)(41300700001)(6506007)(33656002)(478600001)(186003)(83380400001)(26005)(71200400001)(38070700005)(2616005)(966005)(6512007)(2906002)(6486002)(36756003)(86362001)(91956017)(5660300002)(66946007)(64756008)(66556008)(66476007)(76116006)(4326008)(6916009)(66446008)(122000001)(8936002)(8676002)(316002)(38100700002)(54906003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9X2B3JXeijZ8TtTM6jnF66+yCw+yJgKguPjpFfja0GFYmL7FSk8bKa2b2ZJn?=
 =?us-ascii?Q?OuhEqJwyQFePk2617rJq8QluKus9NNgSA69YSl9m/2kZznNTtcm0FEye/Qsx?=
 =?us-ascii?Q?uuVPtKrti/GUcOsKvaEq5CenrQflRPain/P6Vrw8dThAlb8VcfXSGdX4z+zf?=
 =?us-ascii?Q?AaBSv6qj2AFZD5U/fmX+PtakCOX+kMQvvh3ywc6uWPzO4kb34AZt+AR9i6tj?=
 =?us-ascii?Q?wkBylQUXc1AXfivzPVRpfD+w68qujImdbqwpnE7RNqO8IRXzU4+BZ9Bw+QUB?=
 =?us-ascii?Q?gD13rG06qRBWLA0m/webP1UnR9HSL837GVXa/NQgaoFLTt09sF4gJO0WHjhX?=
 =?us-ascii?Q?7DUZg3d99PZggUsjVODCv+laQInJAwy6NhlIovFymCfhxe+tP5ND5k8G1HgP?=
 =?us-ascii?Q?knhZPu8IM9rstQq9BatvsssnoQeMoxangXWVgBz7PFvF73aLTNA7r8jHu15K?=
 =?us-ascii?Q?XROggqnnJyn2CeB/rtbjdVuLPtM6uVSTyS4kjM65glx2McPf4dsWdTbSKAxx?=
 =?us-ascii?Q?0YTUZjxIE5Oz5PdilsVfnyCe2CBsmB4WWJe3P+svbz6Ic1GiD5d8Z7BrrnQU?=
 =?us-ascii?Q?JQ5oio4YZNRWCjS1TgBa8Wj+UOhoGlWU5kN8hB+F/Tymxcd0PcBYqdXq/lo6?=
 =?us-ascii?Q?/tfZP/+qllwFu2Xf3AtyneVpZttZW0E5uSoP/AU4NpW0jZrqa2V2ZTYpZWgx?=
 =?us-ascii?Q?dfHNbY1wrLkTPVTB+Sp1fQ+rIhe1AS7zSUbYv3KDQxH9fHn8bMU3CtdUjIte?=
 =?us-ascii?Q?yMYTEgpUIYxCRG2StlA8emE7w0vDxEn4UeXpXivX2byovowI3FcLnu6vfoiQ?=
 =?us-ascii?Q?RAM08LZTGUQrm9EEFXY8oJcdtJThJ96Id0uKEa6KBtSlVMjOHgzAnizKBqAW?=
 =?us-ascii?Q?EzmmZZA5FYB6waPgoT4Hr3eownGjDaNqAoqxK0A3PgQanHHaEBSXRgrXiZUE?=
 =?us-ascii?Q?HxvOVD6Or9Xhh7zVudmBRvPZwtD0/nXnlU8kvLIhi2+KifYaZ9MC52n7iz1K?=
 =?us-ascii?Q?MEroHKIhwzDPmudj9gruxwysGY8u6jt99vTNv/U9dft1PZhJ9xU5aaoZ20nK?=
 =?us-ascii?Q?iJku4Q5RZFc8zGk4BDmqvZMXjFu6SnWxC4NSw/v2FGhRZQQnuG838s8buoN/?=
 =?us-ascii?Q?UVOyqGzUyH0Vd8oFKtC6KUGMqxp8niY245Xr+Y3WBTgZD9DKzw3ZgKG87box?=
 =?us-ascii?Q?aXO9jJ3oIZC9QRPJNsJd/nTdLNmJsEWuRNFxcG/CJ5P7WvBRSdu4vIb00eWF?=
 =?us-ascii?Q?HIF2Jwi8g51t1ECNo58bqST2N+giYtf6CwP/n4hhZzrTMkYNni0nMQrNguC9?=
 =?us-ascii?Q?7YwnfSNivoxyvDNSfa1SsuxBVvSeN2bBfumjblqGYOo9gFFBIC0uy04he6Wl?=
 =?us-ascii?Q?tfd8sEFXkcKf0dcavguRTwumDzCLHM/LjJHne8R7gBs0PL00yJv4ui69EC72?=
 =?us-ascii?Q?ihH53iAFD68fpNMKz/DbwTsE1VzW1yAOlnjrbvauBYdulHNFMzN9KzmXpgxT?=
 =?us-ascii?Q?B5GXWW4MtrQHPo9n0ExHCCLXnBOnQdpexC/QDpgLu3NuwQ8eNbOQ/DkzadAy?=
 =?us-ascii?Q?6Tfl30AnFlaCIc+3EDbh9AZqakDw0KlINIPB+vqEYVp6nSDtTVJ6bNaxvJHZ?=
 =?us-ascii?Q?Aw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <32DD2EF1A2B6F64284CF7F16030D1010@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?xEKYR46cgj9HyLMbeydYzShl5/Dn7d80gxwqOCnyZmeAKNrZnr+fvfPkeqcb?=
 =?us-ascii?Q?T9E5gKtvL90e6O3gsMT9x24iwVdTH6V7RJVTaRin82NypupN5Td8ubzAxlhl?=
 =?us-ascii?Q?71jhT6N71zpAJuyu/US0znQTkpQIRwgo+WYSfbOTALNeyEbatyFN/61pAbVQ?=
 =?us-ascii?Q?mX1ySWk2TTajKXRgbL1Doqjy5YhJlaolQdCc7H2VT/j0t/Xn1/oGANnBcpwm?=
 =?us-ascii?Q?L+IdyDdoXNw8xnHfulbg9nXwTTTpSP80fVGZYdP0qi9NkaV2DoiWQLVjnTtT?=
 =?us-ascii?Q?lbzYh6IU4F8C1IFs8IMY315XF/evG5O4eIpGeuQ9CmoEtnMnW968l4+XDYpR?=
 =?us-ascii?Q?kgY7Xm+NTVft0tlXpgBjO97vAgT4oSBcyR99iv2JufmJsce+1+rfE/yC7LtC?=
 =?us-ascii?Q?NBEWD2KTbTv1fIZ+e3Te/LZ6n/ihzoHns3AgJ4NEw+M+dbK01IBu9GXKyYZL?=
 =?us-ascii?Q?7rij7koCDuzm9zXdEbP3HQ3mQ4c9wS2b+Qn8rf8+QY4vOMesxxbUib7O8Opz?=
 =?us-ascii?Q?j+CnLrc/G0q723wzqGRrEIv5JgO4InVbMR0imAxn9A4hCpOmZzxpkVbwfuAj?=
 =?us-ascii?Q?eBAT93tJq/PKm9+70d4ISAG04SjYmJVBeSxGraIhE8876rc9n2nL1be1BnCH?=
 =?us-ascii?Q?03ZeesE7/lfi+cyaLdVFyx3y/aSigyth9J4TkclLLHQUubCPjd91Hs2WBsLu?=
 =?us-ascii?Q?vnvqdQT6xcNi/wT15lH+zRweGkqS823GVEu4hear/MN5tFcdMXh53zTY8G8J?=
 =?us-ascii?Q?1062HMCdq/WuB9MNz9A6e/1kbDeXL+m5U1k2+qY3Ngk+qgf/KsenYeiemRqd?=
 =?us-ascii?Q?5+/8LLv/zp+hqEyK5d0QGY1igYOu3HHakeoSzKbqGq70Hrd2UjOGH4+wbrcN?=
 =?us-ascii?Q?RunSLaAvTSh+CKnQZ4OPbzbztktNy1Aw45KuhuvT+AGp2J0peleXiBuafbeV?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44feccf3-6fd1-4203-13bc-08db8d120583
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2023 13:21:14.4080
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JROwhP8MXCm7v9v1J0SfVK/zFfVg+2XIeGNtrn/cp+hFjb22bIO1gaUyYY3I0ai/JXvTSOq5Gtvg7g5x34iwFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5589
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_08,2023-07-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307250117
X-Proofpoint-ORIG-GUID: 5Lm3K6TICFPEB-1TGAml_Hbv4JWVeSt8
X-Proofpoint-GUID: 5Lm3K6TICFPEB-1TGAml_Hbv4JWVeSt8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 25, 2023, at 5:57 AM, Linux regression tracking (Thorsten Leemhuis=
) <regressions@leemhuis.info> wrote:
>=20
> On 12.07.23 15:29, Chuck Lever III wrote:
>>> On Jul 12, 2023, at 7:34 AM, Chengming Zhou <chengming.zhou@linux.dev> =
wrote:
>>> On 2023/7/11 20:01, Christoph Hellwig wrote:
>>>> On Mon, Jul 10, 2023 at 05:40:42PM +0000, Chuck Lever III wrote:
>>>>>> blk_rq_init_flush(rq);
>>>>>> - rq->flush.seq |=3D REQ_FSEQ_POSTFLUSH;
>>>>>> + rq->flush.seq |=3D REQ_FSEQ_PREFLUSH;
>>>>>> spin_lock_irq(&fq->mq_flush_lock);
>>>>>> list_move_tail(&rq->flush.list, &fq->flush_data_in_flight);
>>>>>> spin_unlock_irq(&fq->mq_flush_lock);
>>>>>=20
>>>>> Thanks for the quick response. No change.
>>>> I'm a bit lost and still can't reprodce.  Below is a patch with the
>>>> only behavior differences I can find.  It has two "#if 1" blocks,
>>>> which I'll need to bisect to to find out which made it work (if any,
>>>> but I hope so).
>>>=20
>>> I tried today to reproduce, but can't unfortunately.
>>>=20
>>> Could you please also try the fix patch [1] from Ross Lagerwall that fi=
xes
>>> IO hung problem of plug recursive flush?
>>>=20
>>> (Since the main difference is that post-flush requests now can go into =
plug.)
>>>=20
>>> [1] https://lore.kernel.org/all/20230711160434.248868-1-ross.lagerwall@=
citrix.com/
>>=20
>> Thanks for the suggestion. No change, unfortunately.
>=20
> Chuck, what's the status here? This thread looks stalled, that's why I
> wonder.
>=20
> FWIW, I noticed a commit with a Fixes: tag for your culprit in next (see
> 28b24123747098 ("blk-flush: fix rq->flush.seq for post-flush
> requests")). But unless I missed something you are not CCed, so I guess
> that's a different issue?

Hi Thorsten-

This issue was fixed in 6.5-rc2 by commit

9f87fc4d72f5 ("block: queue data commands from the flush state machine at t=
he head")


--
Chuck Lever


