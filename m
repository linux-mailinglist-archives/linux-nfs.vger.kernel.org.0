Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89F3C487D33
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Jan 2022 20:41:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233033AbiAGTlS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 7 Jan 2022 14:41:18 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:44694 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230209AbiAGTlR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 7 Jan 2022 14:41:17 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 207HbAdG021795;
        Fri, 7 Jan 2022 19:41:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=K1YBeJ2gJH+kvmTVw8h2t85AGAcB3X5a0BOca5mFU0k=;
 b=cEeszHUMga0ipVsW8QQB3qVH4MunuavFe0aywF7wL+K2ZiHERvZXBlSUYd45gsgwMHKP
 nokJ8B1VxorQtNvdW7mJmtRXeenpuyFMNRseBtDKqsczYuED8R+TsDi0NrCekn/psnS1
 PX1DccMhoALJk5xM6YuAo9PImpzG+7rfHODa66g0iidSEYSkx3GutSyf1OY1U0JIKkqV
 uVpSx3eGPAS1f4MyZ4sq1/aS8xKZr1iWTrPcKt7zkFsIlY2bLJrdGqAmPpPcPD1D53es
 FDOUoFmtdW2a4Mpx0PG6+hLA7TFwAI5X3QejrYTzCFhGY3H2nzehZ5Xukx7hnPPneg0g ww== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3de4va2tdb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jan 2022 19:41:16 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 207JZPE2076957;
        Fri, 7 Jan 2022 19:41:15 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by userp3020.oracle.com with ESMTP id 3de4vp65vk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jan 2022 19:41:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M2z0mXcB0y3qqG3cffu97B0/JdMg8tcmsxJ6i85V5aoQiXOSIdsxetJPYjycie/xqj1gl8K0o8D7lNP4H811vbp4AoXCTR2tKBwr16XSYL2tnwbzSZPu6qPezpWXTYaqDZsBumL0pn7AsriGdrZH9qN66D6TjM5V0rc0T1QR7KVi70+YBWHrtL2F5/x1WCN2vXHuC5CdjdJBYWdDSyd5M8ePY0uDi1CVsU0odwxkyOJby12BgqauoPtbxdytLgq1VU083OvKIoWgppFv0XC88LJOsw1AyaEHtmXh3dgeSFF3oDRDGj5TodSjelCyQlScfuFMsrZuT58YqxCJbMfSWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K1YBeJ2gJH+kvmTVw8h2t85AGAcB3X5a0BOca5mFU0k=;
 b=BsW6tfx9zcR3ov90mERXbVo7s59vC+qX+BeYKPy1fGSRg9SLcbal3787cat9QIOfpaSlTvheqDBsJkQKwvNUpCvEXobSDKhPvnlPk6CgvxA+oxoH3U24VNpgeHtp90GkvPyXWiWbIBOgKxPtfla+xZWiFbQeWwE6HoUU2DxD5xGeqoufoZVAdglAysn9Ua4pTtvLI8gCYrfYWARrK/Av4tejb+Q5wyrKUd7lQypdeCaLlCk55kh4QyNdCJrkD9mNfTMZUALoeFYrjbLxS9TqyDhNvfyuCUOd3n+Pbb++XOZqrvv8fquP7EfTruSfHHeBBqCsXyQwOmAb7y+MWxDv4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1YBeJ2gJH+kvmTVw8h2t85AGAcB3X5a0BOca5mFU0k=;
 b=V3DbT6V0AssqWxmTAmGhAx80C7uWkizbhTHK14vwjs9XGP4l4CNBOa1BPiP/jRpuKHM7AG4O7yrnl6LcCf/Nzg5+UI1X+vw+Ybws7oyYGX67RohmUH/wopzHQDYQRTdi/cvORsW16/QvDQgQ60bTCrVqkOV95EZQPCUdeVcSvcQ=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by CH2PR10MB4229.namprd10.prod.outlook.com (2603:10b6:610:7a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Fri, 7 Jan
 2022 19:41:12 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7%8]) with mapi id 15.20.4867.011; Fri, 7 Jan 2022
 19:41:12 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: pynfs regression with nfs4.1 RNM18, RNM19 and RNM20 with ext4
Thread-Topic: pynfs regression with nfs4.1 RNM18, RNM19 and RNM20 with ext4
Thread-Index: AQHYA/r+SlDRdGyMa0u1cSC2aAH9gKxX9RWA
Date:   Fri, 7 Jan 2022 19:41:12 +0000
Message-ID: <3D2F2375-DDF0-424F-925A-B3BF4457FFE2@oracle.com>
References: <CAPt2mGNF=iZkXGa93yjKQG5EsvUucun1TMhN5zM-6Gp07Bni2g@mail.gmail.com>
 <20220107171755.GD26961@fieldses.org>
 <46407a8e-8011-9cdc-4db5-5679e2b59957@oracle.com>
In-Reply-To: <46407a8e-8011-9cdc-4db5-5679e2b59957@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 589c60f0-9081-407e-e6ee-08d9d215a93a
x-ms-traffictypediagnostic: CH2PR10MB4229:EE_
x-microsoft-antispam-prvs: <CH2PR10MB4229A89D9CFBEE359EA44319934D9@CH2PR10MB4229.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RJLZkZrq2NR46sTWByKv2LFnALXu1YWCajWbapUs/z4xk0mVkTXTXmAC+B6wfybNhf19z8xvGXnPETjHrmFz81SbojRvK+cY+JuaEdCGPQ0/Bq/+Agi4yjmHbyAUHce6Q8YvASvPhgAz2+0IbCEk/MhYYYYuM851cO3h1gw+p1+LW3ffYc+6qRDlnyRubFFvNIrvrdyjTg4Fz0aAa8ZXgPfeXFMY2uHI/VxgGwX0vXaa7HjsbrV4IZqTOgbESNccy/X/+Ypz1FIOApcoG//Rm1297buMQ1U0L4RLnvsYRgzlIot3jk6MS9i/BOBHub6+Rw5+pxON3Y9Ytz5q1XJpdLdQUSlOrrE/dIVHUnKQinVYq6H4NgkVaZXCLo9PW87PSAoMBqaRzSAnLfjI4GWjnxJtA4LfuJ7Z0X3McbubLS9Kj15hzUGZx/RWnd6yYjXaCTlkOsFmITIOW4SwWUUx1yL0KiMfubs5YODEATs9VyOK3B/3bwU1A26jGaU5zM627jpwFyuCGuh1VNvpYVlvBPJMVNTw5osMMjdkVeklAU1YhUWij7BplOpmkvkD7dwVLSCKgQj9BbvU4sKGlswTEaus/xboIqXctAK+cZTNrXUtGUG4+0a59zlZ7MieMlZcgLM2BrtDLocPmDmpB+2iGMmvZvqaG2E/AW2RGTO+bAJh5YD6BBIsw3A4W6t+zGG0dsSsez0m3hAi/PHfg6ASh+5UyakLOBb0Gu5+SXFNEqE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(64756008)(66446008)(122000001)(66476007)(5660300002)(26005)(186003)(76116006)(6636002)(316002)(2616005)(8676002)(38100700002)(8936002)(38070700005)(2906002)(86362001)(66556008)(66946007)(6486002)(4326008)(508600001)(6862004)(33656002)(36756003)(4744005)(83380400001)(71200400001)(37006003)(53546011)(6506007)(54906003)(6512007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1Z78vE+kr3HPTER2roB02ChfMv0cGuA1lTKMKH71a/cGbUuyRjf4It1LILON?=
 =?us-ascii?Q?1yAw3NNDG7vm9oCRMJJauoTLNDzb+grRCzbUeCEcaC/Jh+QZ7b6+pGIcugvV?=
 =?us-ascii?Q?eIy65N1IrcQK8JcCz2oZNd6P7OhE11KXD0uE5Vov7lA5U69w3MU0HQcy7vx0?=
 =?us-ascii?Q?1AiFdenrc0m5qc+QOD/QrMUbhU0DPnoVdWr0TZf+Bewt8esEjH1QguyQhgCM?=
 =?us-ascii?Q?KegYFNyJHIuLJJUKSSEY44aQFaHTTLeykNIToZeY3EH6EX2g6hWSKqUqwG8R?=
 =?us-ascii?Q?oSvP4k45/h/D8YMozUpxVuzPWdDbvOxU3/HIXHZa82T94IN1EZOCGuWXYo/2?=
 =?us-ascii?Q?4MO3vnFhEcA3uU+GGkwVIBnzhY4JX4PLMNIQgqE/yW9Y9FQcWHyvbzouD2wZ?=
 =?us-ascii?Q?TmEMBbwBVuEOcBMLFzDJHARFFkeK4jhIAk/1FDKTaFWGZFoPNKDyfWFnHklN?=
 =?us-ascii?Q?YHhXkHujp3nhVJ198XpIprZ7YRvsWBsXcNosKTkdqaOeermr1GIgskAxGKde?=
 =?us-ascii?Q?L67ryQc+oJ9q+7H2afkt673bOy3eTvx6/5/QWjiK0NaqQ5us8MUi6LHu+S1y?=
 =?us-ascii?Q?4+IbA0Aeyi4rYTZ9vB91mOC4NuLOlxMsYMWpAe1+x63PMoWNFwoyI03f7Nfd?=
 =?us-ascii?Q?b8eiIyL0nw+1eyo80GfxIPQ1JNDrmbtPhquBQ691xZm+rSxqG0kncndbqvkx?=
 =?us-ascii?Q?dCc+shaZHExsBAqUKveNR+8lcDda18vRoVr80egHEfYg1FVNyvDj97sTS64n?=
 =?us-ascii?Q?PCl48JgOLjy+7a48asvlAQRMliiMWU0W4MVSuAypGgA51v5EKWB3SwdTcW0R?=
 =?us-ascii?Q?NWlvQoDWiyI8meCJcc0IRPIPWWWLkvI9246B9w+mYg7Bn+/6NU1mdwBlKujT?=
 =?us-ascii?Q?OGte+L/uuWSWnh0Y7octouj/DLonVvJ6vFalPZEHZnzj6XACfgAtOBRQbnU2?=
 =?us-ascii?Q?ufVDreeGKeauC3qV0ytH96/QHEHTZBOidCBDZvjlw28TZyXX4BZPnTdwe+Jx?=
 =?us-ascii?Q?xH58ODSbYa4+rM+9EvCKcPMxivSCxwX3tZEyVMgGJZDYkqEvSBcJBNj2VnN2?=
 =?us-ascii?Q?mG9XViZyOuoNwYXybrvpvXoDBlytMpQPxYWFfYhrk5tj9tlggo6+LCdK5qwg?=
 =?us-ascii?Q?i4+QheD/T772gPteByhI6KosRGjkKfG4dPzOup+VX64fTMncl+a619LKZD7h?=
 =?us-ascii?Q?RldvOYrB5hGz7yXUfZriuQGrwzRsTQmTldhy2fn10bBkFuhM6ek+nBGGBobp?=
 =?us-ascii?Q?4HZP3si/GjiOtKbZmYKncLMHEHvtvDJAPZE/yOsO6Atl8mWcsm+fCMOidHVo?=
 =?us-ascii?Q?MiBEwvR5qsZmSqd+ibF5tvGQ0Ig90c2XVBX8h+Ir9IqFupLdJtJPpd/77JJC?=
 =?us-ascii?Q?jcBpZoRv969UbCRHT4+m99Lx96vJR98GDk9uGIneldoOYk1bQxtGIzf3KflX?=
 =?us-ascii?Q?eKcOIJxePRsP/+O9CVuq1L7j6F3ACDaWJKHSDF1ZPB+QqfgDgjX6Imy4KLY9?=
 =?us-ascii?Q?15EXP9+cErUShcqb13Zk7pnl4DPDonN3L38KUgdp0eUu9NZDIyLSI6EKlBEe?=
 =?us-ascii?Q?BL2X3ZGrxaiagoDjAHoHk9jbGVFLJ+bT2WgeIFp/+7hX0MYEsZJawk3DZZxt?=
 =?us-ascii?Q?gSuncHuIBQjxEAwCnoYtlPc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AB94A082846F034C8EBBF233A138315A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 589c60f0-9081-407e-e6ee-08d9d215a93a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2022 19:41:12.4366
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zdIg7N8FKmQgTVuSKYWPm9mh2vXRRJatzwb8+/i58+jqwA5mduqzWbFck1DPwas4PNp8+72GOavWC1JVmmGR4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4229
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10220 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201070121
X-Proofpoint-ORIG-GUID: tOO5HDkPukHBzN9VmpT7--5ZDakv3j1s
X-Proofpoint-GUID: tOO5HDkPukHBzN9VmpT7--5ZDakv3j1s
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Dai-

> On Jan 7, 2022, at 2:15 PM, dai.ngo@oracle.com wrote:
>=20
> Hi Bruce,
>=20
> Commit428a23d2bf0ca 'nfsd: skip some unnecessary stats in the v4 case' ca=
uses these tests to fail when the filesystem is ext4. It works fine with bt=
rfs and xfs. The reason it fails with EXT4 is because ext4 does not have i_=
version-supporting. The SB_I_VERSION is not set in the super block so we sk=
ip the fh_getattr and just use fh_post_attr which is 0 to fill fh_post_chan=
ge. I'm not quite sure what's the fix for this. If we skip the fs_getattr
> for v4 thenfh_post_attr is 0 which causes the returned change attribute t=
o be 0. -Dai

I've got a fix for this issue scheduled for v5.17, and hopefully
it can be back-ported to stable kernels too.


--
Chuck Lever



