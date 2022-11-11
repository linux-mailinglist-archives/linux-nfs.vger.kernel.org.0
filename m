Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B36AB625E4A
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Nov 2022 16:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbiKKPZj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 11 Nov 2022 10:25:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbiKKPZi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 11 Nov 2022 10:25:38 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC05F50
        for <linux-nfs@vger.kernel.org>; Fri, 11 Nov 2022 07:25:36 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2ABFHRh7019901;
        Fri, 11 Nov 2022 15:25:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=u+1c7wyeF9+C9+TrXlkom1En19Ptf6XNMoPGz7Ephjo=;
 b=0OXeq3D9AgBGus4HDthxTYd07/tCY6zYMlF2nytRmegP8SMrxu6Cf3xUWNHJKqfAgYIC
 gzKw0tfZo65YgyjY5JpDI7ItRqdJcAF8OrOLWiwiSN0j1vRXWYHnLjN+rkEfDzNFZuE5
 N5515NBYOkNteNo3k30cZLLmU2YfBLOuYokIp+0iLMTPSvdKZQLypA/uLQ79WgZZkDE4
 4Qt4juBCHjBwrtpEPA6YFWKCPo8IOv6aMa+jU3sy5OhObYg9Wcs34jsURlQGfPc60c5B
 jb9C7xkFVhbzuQ8V0hfct2QpJcDxGtziv/5l1judLMa/tYTNDk8CW27N4dTXO06nSpx7 uw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ksre683ch-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Nov 2022 15:25:33 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ABDWpSs022452;
        Fri, 11 Nov 2022 15:25:31 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kpcytfc42-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Nov 2022 15:25:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IppjBz+FzmdercPLQXpDv9s5plGBdLkK2BUXhV4xtBfviFJTPzP60VozH6qEtabp+U5GJRK1KlJJWMF2V9y7pevdLRQ4hl3zVEfyxHt9IFtdLAFF/W1ZMjkWQTj30j2vk8yNCCaLqUQUmusCAIGnl0Xxh/ZsAZs/DHep3yEwTt43bBfOHVR7zX/Cwq/5x5OvzfMBFhyKnypRkcVBqYi5j3heN2lMUbOrKCsoZsU+TmaMscbeAKbTYoucChaRtCy5r46WCmWm2SJYAN1rjH9Gm/+Tf4oSztU4gdcpWygQmE3/zsRMeBEJlghJ/nfTt5u6vilTvIBk2n8qXAMzytGtWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u+1c7wyeF9+C9+TrXlkom1En19Ptf6XNMoPGz7Ephjo=;
 b=QqWCSfe4g4T/6wuVUw11wAHvRDZneFP5rMsf5uxtxOsPmY05lfsTXU+keD6aF5zgbirFVteKqia52xz4Qr/TFHw4Cqq1kLJbJuJNfCLhtVv2k9rv7sX+z06FAgowl1LKckBZW7DZIzBgx4uDZj/544jLd3Akg0FxFnMc708tzfrMiAa5gH130d0osJkkaelLb+c2elnSuvfLNZC6EUKhJxcASqm6CFnKfVzFqMTFJqKmX00XBX9fQhSQB/TV5nf5X/kQi4uUwnEETOr9xUy/+CyJLjn0Se8gZToHncpnaeGbnMcQILnXnoZnfdAVVDAKj99NyZ/uc60HvF6HCWdO1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u+1c7wyeF9+C9+TrXlkom1En19Ptf6XNMoPGz7Ephjo=;
 b=I2uqyh4sVkfgJy47irHZYAFR3sOSzFB2KxEw/ZIIJ/tGTegq3a6iGA444z+mPCers7ItCEZTgdSmeL7+HEvBi1kctjMGMRC9CNCyqroK6cYU1lRfMTb6AAZH6a8kzA0UcZv52Q5esRCyNZ18Z2igjyGdw/pyXdn0OsOisY+BCA0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW4PR10MB5680.namprd10.prod.outlook.com (2603:10b6:303:18e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Fri, 11 Nov
 2022 15:25:29 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::b500:ee42:3ca6:8a9e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::b500:ee42:3ca6:8a9e%6]) with mapi id 15.20.5813.013; Fri, 11 Nov 2022
 15:25:29 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     "jlayton@kernel.org" <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v4 3/3] NFSD: add CB_RECALL_ANY tracepoints
Thread-Topic: [PATCH v4 3/3] NFSD: add CB_RECALL_ANY tracepoints
Thread-Index: AQHY9LtZeVXT8D2f3EuoKPtp4QoFca452jEA
Date:   Fri, 11 Nov 2022 15:25:29 +0000
Message-ID: <F69554A8-20BB-482E-AF8A-94F90B1081FD@oracle.com>
References: <1668053831-7662-1-git-send-email-dai.ngo@oracle.com>
 <1668053831-7662-4-git-send-email-dai.ngo@oracle.com>
In-Reply-To: <1668053831-7662-4-git-send-email-dai.ngo@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|MW4PR10MB5680:EE_
x-ms-office365-filtering-correlation-id: dc73ef91-2678-4f4e-47ef-08dac3f8f732
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lEhg1oLV+DuYTFwoTuOo+WKpMn3gug4XKln3Ri89+t9Q6rEAWZXhL4Xx4A/u7I6RpgGTXXY676Rx+3NEN8zdeFH7OfrMa8Ux/XSib7A7Q96ExSaoPxO6C2FJw1iz0pdE2+olLoAfs+SEB6oc5bbYpgIA5CE5aIrdd+ic52VC0iSA07CT5rbPy8WBjE5W2K+uxyl5ZROJd7O16tX6s24Nf/p9x9A5vaSovZqymMLVFZL9U+Q4eNm0bHTkx0cmwidtAP2EZHZ60iOV8EQ3tRX74r4yAm946xUwd/2st/TQCtHPe4ZrK9g2sVNe+z4ScK2KlPZYw9aTpV9IoB/UIVH7blxS6JGwMUDf+qZr+pc3gMNeUr0gAsE0BRzI1wC4hQGPyjtCrWMq3HT2WIw9NkHS11IwANwInWD6Orx9tpPsRgQwJui5ITQJld9AsyVj+VvAFRC8tGPQ9dvPCi3H1PnWYAuL0gy4HmafiKInuErmQFs90+8PqO1/1sp89WkuRtL78x2/sBZhV+R//2RSZ7gTVz6j3f0Jf8eIrFRC9zlfzTG1wvUi8oa8pVoz8Q9JFvgBZWnjuT6Zokc2XF+p4qrOyJS0iV13FkKCpOYPJoe/8DIisgYJ1eycUot32gMbFXWwJia/DX2p9PsewWexyas4hTo4z+EZXEZWDFYNeVrQ8rcBHrB1OLUVO22FJeHn0VefnSOBv5HL+GwsRIEbGp0vR2VtWwbPXEjpF/t1GEd/mpU8kpC6OB7bAgr8UbIoQp2WY2sBQBqxE/T27grb4OUiE9UrA0Mu4rWxMgQFNGD7CNc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(376002)(366004)(346002)(39860400002)(451199015)(38070700005)(8936002)(41300700001)(5660300002)(8676002)(4326008)(6862004)(64756008)(86362001)(2906002)(37006003)(54906003)(6486002)(6636002)(316002)(66476007)(66446008)(36756003)(91956017)(71200400001)(76116006)(66946007)(478600001)(186003)(33656002)(53546011)(6512007)(2616005)(83380400001)(38100700002)(66556008)(6506007)(122000001)(26005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7mPO+nQuA8/3WVwQ7VtV57X/KD82MFnP9Vtmav3doC+c9bvjWgWZrYJux3aE?=
 =?us-ascii?Q?gitC9ML4QQKt8LyAi7cdCtek5jWgmkHil/LatwwnYZWbS4QhRBusE3tIlnNP?=
 =?us-ascii?Q?P1dr+x0fajfKQYYrvw5s2jmgNkx687s7Fq8Or1BYiIkIyXD8WxGjPqejnjVo?=
 =?us-ascii?Q?TbWFf+Rixxd3qWokWSpl2GK4pm5f2A2KUbrSf9oIFNVM6HEpgrwia/VMKqR6?=
 =?us-ascii?Q?Nx7FxGTaPIttDMX4Kopjwub+PQOtyI2kf0x5ls4pjhIRBXKuREXwf0eyfPft?=
 =?us-ascii?Q?k1v6NPfbd1DIY/saFi3bwBOaE9rDsDcP8ZgvcJqCsFkTx3zvo5Twt22Sc/Zs?=
 =?us-ascii?Q?rs2UFfWHC0EsEozeO3L8FFKcCQ2sZCHWz6IyMjwwM8pGpDDfp1s7h11FZwOx?=
 =?us-ascii?Q?YN10xtITOnkMR+JtmjofthDhAYp9uaxLGShX39uYdXbJDnCixQA9R2fdEwIS?=
 =?us-ascii?Q?Cn6ovHDCVMve+7arW38JBGOHq1gg91kQ3209Zf7gfuE2B1h3eKyFR7Pr3qk+?=
 =?us-ascii?Q?UcZ6UBIhUMy3ipyGnFbdyrohp38DHHkoe3WtP7jvQHVHbzPu0iF28TQFd8jL?=
 =?us-ascii?Q?QRpWgCfhdNhBiQ3Pv2irJCUGGI9Bula5oxwrTZCzpgz9MSU46AygAk1J+c+r?=
 =?us-ascii?Q?j226mvdpe1e167cnpjC0XJ0Jwiox5zpRu8X6xiAZ5nHKbGjEG2yZYv2n0wFh?=
 =?us-ascii?Q?gZWtNB5tl2SIPJhP9BfhQfTpscqhwaPMEsgrrQEQuLl2LTeuFXUnvrCrgt7/?=
 =?us-ascii?Q?WhQkzL8FqJQ3qOEvHLXgPIO2Z+NcnP315nF9Iicr8wek1ygJcocFgf53PZBR?=
 =?us-ascii?Q?aAockk7AGwHta/P7knUMumxrUUK8STLdYOGu8eY96JnziRnvyKf4AHjZnIoL?=
 =?us-ascii?Q?OPbEXAMl3xlf9s/7WVW+TsF7Ho7Y5y+6kWn0893PKb9+P70xwW85FEzRUXT6?=
 =?us-ascii?Q?yuLyDWMX3xoHgu54XXTOzs8qjjZ7AkaafiEisqJClH52/vor2bTjR8s+aHkt?=
 =?us-ascii?Q?EoilEImCUeJdA3RQtZsmJ6qKTM5s/n9Bw6Gr9KTkOx0yyI7ra/0rxTFgvIJi?=
 =?us-ascii?Q?lss//HAsdW70vwGBrgRmjyNsKvM5/D6HN0yi43s5geMm0NFW4LO7bubdpTg4?=
 =?us-ascii?Q?vsvVqvCfN720OJ2jjWrg5RDNp/js3w782ubc9dm/PjyXhBI3woLOuz3lb0JG?=
 =?us-ascii?Q?kqfCnnKve4yVmzC/2bJsr9kotCP4+vhemP2XJZfT7fwsbRy8wdPQVO+oU5EA?=
 =?us-ascii?Q?nuATBBa3p220DB/ReNDcwBTJ1z5Ygu1hAs6gNrfizQAPh71lHqvfko03Dxoi?=
 =?us-ascii?Q?7gyHjYbEwvd1O0J/6Kht4clKyCiwBYiELCMUa2kKttcdFmsZ0EmJtF9ddsy7?=
 =?us-ascii?Q?VOQMPo8yoejjAVtgNKNwebxfRG0gCWpoeYBDliSzQpl504UB6OI3vZXXhxdO?=
 =?us-ascii?Q?PZdcJH1qyQlnPhXU8NPFOwMyOkgkAder1N7GxNChqNrelLB0ud6rRZ6L575e?=
 =?us-ascii?Q?cPEeJZjNRw34Zj1KnVS+Kf0sw+KPdgaZGMdT9LxERm2YhfE6NFf88yitCkY5?=
 =?us-ascii?Q?FPv8ha7ZDroWcAZzTnkdQoSSA9bG4+lvl6VG2ja7zw9MJKsi6nTjaL0qx4V3?=
 =?us-ascii?Q?mQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6141F0DAC4EAF74BB44C4CED572AB776@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 4i7Pju/aRPACguf5EtmLj/zwHfj4CpeOSlu973jqK2/wQumPB7uG7Qs4OCzOxIXiQ4WT4Nc5rCLb+NsmTtkyxNOAYKUmJgSYHa7IRXbcuCZi4cQ7SLNBDykbBnj9sQnejOWLb0tJI/Ltv2J7T7FFkuv3R5Y2uolwHgeE1BEPzq/i1FqGpMQ09+fuCHmnrYL0kPS56YjblbyDaQ2LL/s/1YqvPwa9g7dczTyV3CU0hgWm7qaM6LEE3oZvDv6ruXyEd6tauuI3Kaid68xm3IPV1bBiL+o2FUAohEkbir5J7/v613qfHFICinkTITwI7AgtkEyJ0yr8E5fpyFY7TIWAEOlQxFqFMlR916fyptUHOklqSa9J6Tv7F3YFRD3n0XY406fPQzyHrH4CZRNrpgZXMUN9V7FbDXBhOlRIILduCBsYhRcWM9HIeTyiGivBZeoR1cIlo6lQJpogoW/igUkciE+Qb2UGn0cv/3w4OFzxxYLtArydYJRHChDSRkTG9tst79hWkZG26bHLVCs5aWpqEvCtO5Vd2hhT5zvszzQYA5/IkVgM/lchmmMWebybXzIcqTLUYHITLUBb+1ecRlYGTFZqPkv1Vqe9gi8Kxt8ToOiLO4I/kuOH6xXnuEEV5+GJmAJtf930q1rZmJVDk+teeKy1T7I0Pg0B1ggThLLn71COmgdB3jWMZDm+dy/KXgNGnzln6Jj6oigF8nivzS2sCM7XL2HDbUXKZcpMl7oTEplULljRRKGq7YVagOAxm1oXqUHNyNTU90BiQyCdw74Y1llhNlbjkF+mdldzmR+PpHU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc73ef91-2678-4f4e-47ef-08dac3f8f732
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2022 15:25:29.2607
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pd8a41x8qIBlWrNLhRIM3+pM7kSIeWwq3nZnmz3vtShhBlZK61lU1d0qV+RjM5XF7EIsHJzkkeHco9bQOW0ZeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5680
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-11_08,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 malwarescore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211110102
X-Proofpoint-ORIG-GUID: ZWy4niaGRYWtR3SgDx_kCEc3dDsu1UoY
X-Proofpoint-GUID: ZWy4niaGRYWtR3SgDx_kCEc3dDsu1UoY
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 9, 2022, at 11:17 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
> Add tracepoints to trace start and end of CB_RECALL_ANY operation.
>=20
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
> fs/nfsd/nfs4state.c |  2 ++
> fs/nfsd/trace.h     | 53 ++++++++++++++++++++++++++++++++++++++++++++++++=
+++++
> 2 files changed, 55 insertions(+)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 813cdb67b370..eac7212c9218 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -2859,6 +2859,7 @@ static int
> nfsd4_cb_recall_any_done(struct nfsd4_callback *cb,
> 				struct rpc_task *task)
> {
> +	trace_nfsd_cb_recall_any_done(cb, task);
> 	switch (task->tk_status) {
> 	case -NFS4ERR_DELAY:
> 		rpc_delay(task, 2 * HZ);
> @@ -6242,6 +6243,7 @@ deleg_reaper(struct work_struct *deleg_work)
> 		clp->cl_ra->ra_keep =3D 0;
> 		clp->cl_ra->ra_bmval[0] =3D BIT(RCA4_TYPE_MASK_RDATA_DLG) |
> 						BIT(RCA4_TYPE_MASK_WDATA_DLG);
> +		trace_nfsd_cb_recall_any(clp->cl_ra);
> 		nfsd4_run_cb(&clp->cl_ra->ra_cb);
> 	}
>=20
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index 06a96e955bd0..efc69c96bcbd 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -9,9 +9,11 @@
> #define _NFSD_TRACE_H
>=20
> #include <linux/tracepoint.h>
> +#include <linux/sunrpc/xprt.h>
>=20
> #include "export.h"
> #include "nfsfh.h"
> +#include "xdr4.h"
>=20
> #define NFSD_TRACE_PROC_RES_FIELDS \
> 		__field(unsigned int, netns_ino) \
> @@ -1510,6 +1512,57 @@ DEFINE_NFSD_CB_DONE_EVENT(nfsd_cb_notify_lock_done=
);
> DEFINE_NFSD_CB_DONE_EVENT(nfsd_cb_layout_done);
> DEFINE_NFSD_CB_DONE_EVENT(nfsd_cb_offload_done);
>=20
> +TRACE_EVENT(nfsd_cb_recall_any,
> +	TP_PROTO(
> +		const struct nfsd4_cb_recall_any *ra
> +	),
> +	TP_ARGS(ra),
> +	TP_STRUCT__entry(
> +		__field(u32, cl_boot)
> +		__field(u32, cl_id)
> +		__field(u32, ra_keep)
> +		__field(u32, ra_bmval)
> +		__array(unsigned char, addr, sizeof(struct sockaddr_in6))
> +	),
> +	TP_fast_assign(
> +		__entry->cl_boot =3D ra->ra_cb.cb_clp->cl_clientid.cl_boot;
> +		__entry->cl_id =3D ra->ra_cb.cb_clp->cl_clientid.cl_id;
> +		__entry->ra_keep =3D ra->ra_keep;
> +		__entry->ra_bmval =3D ra->ra_bmval[0];
> +		memcpy(__entry->addr, &ra->ra_cb.cb_clp->cl_addr,
> +			sizeof(struct sockaddr_in6));
> +	),
> +	TP_printk("client %08x:%08x addr=3D%pISpc ra_keep=3D%d ra_bmval=3D0x%x"=
,
> +		__entry->cl_boot, __entry->cl_id,
> +		__entry->addr, __entry->ra_keep, __entry->ra_bmval
> +	)
> +);

This one should go earlier in the file, after "TRACE_EVENT(nfsd_cb_offload,=
"

And let's use __sockaddr() and friends like the other nfsd_cb_ tracepoints.


> +
> +TRACE_EVENT(nfsd_cb_recall_any_done,
> +	TP_PROTO(
> +		const struct nfsd4_callback *cb,
> +		const struct rpc_task *task
> +	),
> +	TP_ARGS(cb, task),
> +	TP_STRUCT__entry(
> +		__field(u32, cl_boot)
> +		__field(u32, cl_id)
> +		__field(int, status)
> +		__array(unsigned char, addr, sizeof(struct sockaddr_in6))
> +	),
> +	TP_fast_assign(
> +		__entry->status =3D task->tk_status;
> +		__entry->cl_boot =3D cb->cb_clp->cl_clientid.cl_boot;
> +		__entry->cl_id =3D cb->cb_clp->cl_clientid.cl_id;
> +		memcpy(__entry->addr, &cb->cb_clp->cl_addr,
> +			sizeof(struct sockaddr_in6));
> +	),
> +	TP_printk("client %08x:%08x addr=3D%pISpc status=3D%d",
> +		__entry->cl_boot, __entry->cl_id,
> +		__entry->addr, __entry->status
> +	)
> +);

I'd like you to change this to

DEFINE_NFSD_CB_DONE_EVENT(nfsd_cb_recall_any_done);


> +
> #endif /* _NFSD_TRACE_H */
>=20
> #undef TRACE_INCLUDE_PATH
> --=20
> 2.9.5
>=20

--
Chuck Lever



