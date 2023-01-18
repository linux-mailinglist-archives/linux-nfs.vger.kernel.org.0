Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD432672743
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Jan 2023 19:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjARSmL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 18 Jan 2023 13:42:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjARSmK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 18 Jan 2023 13:42:10 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE2E144A3
        for <linux-nfs@vger.kernel.org>; Wed, 18 Jan 2023 10:42:08 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30II4LM3004388;
        Wed, 18 Jan 2023 18:42:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=XqEauanxPOmBNQfc+Ub/qwfCOczFMeoXxXWOYh68O1I=;
 b=P9gzkpKmpJl0EY0Z7y43/Gy374ILL/ivF9Fupxeg0QofeyXTUQ/nlaYpgjs0e0e0N5bB
 srNsPv8SP6FwqSrn1o/A31SK4wOiDA7zjiJwMdfYXNIA3y7yjdfoEi0Kt0VXhmlfmzoO
 D8WWJ3JQ3Hq7kwmUlkxFwXbMueYMNTP1U1qCaYTeaFRZylIJmaqFdDT9+zmR2EjqJLHB
 nLR9f+Zkl6N4aNdOLKR5G3+mbUxGOvQNJMU+/ovTGK+Z3UwTTQ3r/dieD+76VVUvo+bG
 P85JpmHIc27ePMBqFaHbhnwwC6VEZmhYE+15+zIWbPFmiSyE89EdD1TuxZ+NGdusnsFG Vg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n40mdfstr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jan 2023 18:42:01 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30IITBIR010726;
        Wed, 18 Jan 2023 18:41:59 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n6p3bgncd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jan 2023 18:41:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dFBnIwc6ZYhUJFhzfhKCY1hDeZOXD/8FjFAxp3wwXMeiJTtJmWXQ6qNawdCMRWwVnsUV38mUTqVp/E+UQhNRyT98AWXhaHOdxCI4689Z0df5mPq+yOeJtYhWaLI7VPCfcuZRzrf/fMyN6UFbu6OG+W/KE7kN3G9Wxsxj18TVPX6ZRJ4jlYxKnlad1mtyVoi6cko4rgNGnKxk8nOkntxvdcSEdVbI55LgRn/oPg5veu7bl+UgqZYDYwJp9UFTI9bz7U8y8wHjzXvHs80gfPb2QD/fdqPS8X3d2vYgmhOa+uSP1iZqk+/La8yofyl+uioYZDFIsF7Tjay3X3XDAQa+yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XqEauanxPOmBNQfc+Ub/qwfCOczFMeoXxXWOYh68O1I=;
 b=hon8x6P1OqpMiniFZa4n9S5/bbK4IFVo2wN4ftwMoqvkXC5wN1ILpriPBgiW5F8F92n2l6VhMAZ2bD+9wdr435EcR4OFWTmn4BJ7EdAaIV+X69gFkpfFzIeKGTAEwvfiPbQ12903D8dP9f4qa0RhF7a47CbNHQMFVBMWgQpi9rrCnXbsO+O1eDqHGJGBJBlttmU8SlTswE2k2VDTCIbUn0DZhcL2ZFJinW6d+16zFoU4yfMAMYpbeQbvsC5UGSG0+oXxmKkgyep4kwJiKoJLV9AwaEW6oySY/dEsrBBb365Y5VAR3PS3LNQzPOveH+pFxgxmb7PGZEuuj48zbz4MfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XqEauanxPOmBNQfc+Ub/qwfCOczFMeoXxXWOYh68O1I=;
 b=bpAYmRcpK5EK1pFUqGaPAFMUeES+Xea8sQiBBVCy37mKJlRHBOuzYuyXQhKRE9b2T2lVeEggmkHLWEoTU/umgYrAeUHLDoLuddLmr9DKPh/knULnroBcJJ5UI25zwZxtes4Qwpp/jTyNz4tQU7oeXn0ow6ONtGWFNzzC0wgywq8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB4992.namprd10.prod.outlook.com (2603:10b6:5:3a1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Wed, 18 Jan
 2023 18:41:58 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9%5]) with mapi id 15.20.6002.013; Wed, 18 Jan 2023
 18:41:57 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>, Shachar Kagan <skagan@nvidia.com>
CC:     Jason Gunthorpe <jgg@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Itay Aveksis <itayav@nvidia.com>, Neil Brown <neilb@suse.de>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v5 3/5] nfsd: rework refcounting in filecache
Thread-Topic: [PATCH v5 3/5] nfsd: rework refcounting in filecache
Thread-Index: AQHY7gDKf+UJMCSoA0e+WwOAy53hT66jMXqAgAABmICAAAooAIABoAyAgAAIXYCAABdvAA==
Date:   Wed, 18 Jan 2023 18:41:56 +0000
Message-ID: <671019FD-274D-4A54-B684-DE4C739D6AF8@oracle.com>
References: <20221101144647.136696-1-jlayton@kernel.org>
 <20221101144647.136696-4-jlayton@kernel.org> <Y8a766ypSbKbevTJ@nvidia.com>
 <9CAD601F-C323-405F-840A-9CBAF520948B@oracle.com>
 <d69c0c643c23c56408640c4b7d4fc2acac4bc66f.camel@kernel.org>
 <MN2PR12MB4486E3A2E31CC6E8674E7059B9C79@MN2PR12MB4486.namprd12.prod.outlook.com>
 <a2c70d7d715b11c84612a119048d1c15b2dba83f.camel@kernel.org>
In-Reply-To: <a2c70d7d715b11c84612a119048d1c15b2dba83f.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DS7PR10MB4992:EE_
x-ms-office365-filtering-correlation-id: 61613a93-4874-4cb6-f3bd-08daf983ad79
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RMXFAxHWwYIguTuiA2NufQA2/W4tjgR03QSL52cc+/UQiBvWP1KVzuOc3RoYSszfWx7MSkhQgFKt3d3hqbj5X9DS9CVHLkvxiMphQJnAdfAjplCGetOKnFmfwGGAcQ2MADUlQaZ67jGdqn0Cj6KT4fN0PZB3V5QSHLlJmSDHQf7NcuGYx2NOl2GsFD5ri0eVWg/NubniY+OTi/yAIYmtFmKWs7tkSYBxZs/XGAx1ziF5XMfMx63TMBlMR1JXp7NCbiFsFR3cIgxItV0SWOS17XCzBblkTZ8Xcl4itkL5L5R5e1e7pFJwmUZO300FtM/fnNqck6r7AD0z83Os1p+XZc9eSaegPYGwgyXvdfLKTgQTXWmc9dssuYpldOfRhZaAerxIlWib2hAtLHTiylGYOfrAq4896OsPNKyswgF/38wg0nqpQ6I2aNht90hSOKorugOZaMJtNQDGpx245gyHnE7D4UToVJsIXIrBuddIuk2ifDdqFyjT+ykVnikSIjSdnxfst4E14Il9w9aRpI0wSRyQBUJgAvAr/2UadU5F7K4mp5D6H4lFmDKuj4M2jGYnvdyK2TwzE1iH4trhMr8vagKR/8lkuBUiWG+rW3Vo87MPFdHnTB3pA/xNZAFtpYLsSl1ntw8nPQA86vm5wrmJoTI00ockxB8LwWQ5MHSN1oEKuA4c6mEx/gTndOZsGA+wM7o2vT0vlKFG98LuOzZDtGBFg6zxIpc6lOxuhczIPmA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(346002)(136003)(376002)(39860400002)(451199015)(66476007)(38100700002)(122000001)(86362001)(33656002)(8936002)(5660300002)(2906002)(91956017)(66946007)(66556008)(76116006)(66446008)(64756008)(4326008)(8676002)(41300700001)(2616005)(6512007)(186003)(26005)(83380400001)(53546011)(45080400002)(71200400001)(316002)(54906003)(110136005)(6506007)(38070700005)(6486002)(478600001)(36756003)(66899015)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?h2enAXg13uzQTZoSkGUaeeuyPpJ7hI3uvVhSQf1r0E/TLC4GwbZ8lqNuKF+e?=
 =?us-ascii?Q?NVO8DeW+wFDg1n1v9k5hwZ1FU/zNFplK8V+FeKitvVliq0WylFBxD4N5fb7U?=
 =?us-ascii?Q?l536HB6OSa1aOTMoe4dKeBOUcuhw6yvWbzaFpduk0ogJF4De4fPf3GAsx4UE?=
 =?us-ascii?Q?v6j5UveK1VAbOwwcr5AaB9x4M1vZIrtDNUmPBi/37xtQwhuMO4QULh4kGz11?=
 =?us-ascii?Q?ccJYIcii15iBb3fEco9hMjwMTgVgzXo/TysSw5Em7q4rabqcrkWzqR3nuX1M?=
 =?us-ascii?Q?8qWTnFdnjABXB6hJQFSopuxI5yxfMIB93R4MEwO6zN89jB8w9Wo+neXE5sdn?=
 =?us-ascii?Q?tbmb4qvu9PrtNZfR7bS2SIkHqoJoPz95Z9hNI+ad7Okgh4gEA4bgCIrdkS3R?=
 =?us-ascii?Q?NpDg19mfotqMmgCyDFnIIY8F/63zP7xUT/uHqqWX/Isr8MikNtL6ON3mdcGY?=
 =?us-ascii?Q?XimD0ssQLWBF+kKSZ0wDvi0xIQ2rP10/JIYGJz9iee7SDCm+4VShqdzGr+HO?=
 =?us-ascii?Q?djH/tlpdKK8t1UxmFUMHoFtVZDxdOko8wWQvStDZ02xryZyddaLYXz8GXp1o?=
 =?us-ascii?Q?RDO0DlpKuMJZ1pilkh5UnF5CXHiXeKoVyLofWeMU3RoWVhkoEY9OOmlaj4X/?=
 =?us-ascii?Q?YAd4qFy67sV8aLYyM+0byYBuPjB4p30Gp9blnhjo2KMkFUgKtZA1qWeJxtau?=
 =?us-ascii?Q?dl728WQLSNZKUUeGbFX/VQBGi40InxViOr5dLQLFo9JTDaEkuxYtcdU1NY9q?=
 =?us-ascii?Q?pWboEl9MXkMeieOURlMHAtC7DlYL08g06zyg/9RtshN/a83CJKI6uPS05OHg?=
 =?us-ascii?Q?ZuuYccljqg16CbVsc065g8fT0CoTPzj4PDOLyEmoqhhtxf/5LBzvZVcqu7Xb?=
 =?us-ascii?Q?QYDEciWc6dAszdK+hed3hfnLZRagq1ehkCvOUywUFb6ty6QRY5hDQ//B4vCJ?=
 =?us-ascii?Q?daZ4lApGKZcIboZKebczNzUD4k8KOxthxffsXtzVrUN78RR+jKn5z/kk9gkO?=
 =?us-ascii?Q?qmCN2P7wz6pVYQ8QgH00unCcr2h1TDAsDtDbCQe3oKuhPAVuKxR1I/Y+0Gyd?=
 =?us-ascii?Q?aFxzxsaCQTWSvYj+3PkIgQxKEb9SpFj1zB+yb1Q0AbXytdYIMYzUUPROjIvw?=
 =?us-ascii?Q?Zf2DLgtl4EHJxMmWgGUB7PdZkYZ0eHctn2k9Y7ChrotT5/F4HPNDLe3HB1SF?=
 =?us-ascii?Q?/BocT6HxEwfwGt3i7IRaVW3Se9HrAlrmYx2zivZnJcQdCB+zNdyFPdLHhnUT?=
 =?us-ascii?Q?jODe2VYebWmJcudmurBXfma78FQwM0emnP/UeUUT03ihwVARpDU8yuxvuOsh?=
 =?us-ascii?Q?l831kQSdvBdet9/yS4ndOwGoO9m3ucWfzkgfNY9fVV9Jw0Cx3YapUBftWI6Z?=
 =?us-ascii?Q?jd7NWBIILUAbyCTBeclwQ/s0fH35vOCgFNk9w8+oivDJU3nzJnliTZhgZPfD?=
 =?us-ascii?Q?vgltRIrb7m/Nm4qWiLUcFSE8wjiTjSyBmYWfx2ewwIn7Liph3ycrwVmyc06N?=
 =?us-ascii?Q?0h0yux5ajJIbpj6qaSUawTxEJXXZX8buHp/nQqeUpwTGcQZsITGrrIIbJXr9?=
 =?us-ascii?Q?LbkIPCCz8AGoRNY0Ym42x6t3WJtPdTFkWOZJcrSkLKlcPjRSFywsg+TF5J3r?=
 =?us-ascii?Q?WA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0917CA8874875F488515B95842FFEC6B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: sGPo0vKKrAwqfLYGWeG8ipjnusoFUdjYiJGUtn3yOr3fZI8TcYwF3+OVDzIOvBLrAg9RDOsh/acO2U9Bk3yy/4hGdHSyp5gecixVpL0GoCw44XnP/UV/aXp+T5r9kkaSubz5gLHAermk/T/XUwx35NczzfyWRf1lsjktZIyU2FVq0kszl6JvQ255rcMf4rVRvdW3L2dJ90xQLjWfpNHP3oGUWJR84dIgPiHJmnhD8+954RFqa47ineMSxcn5JFagRodWeA9Iim+kODD/vUDCaEbSHECj4LWacW3wKb0hDtYlEz31lUOj/IsWK+gf1hFzs8qFETNamrBrfh2HsjKlfahf8xWE4iQG8c8rpFRF2ZkKRNUa9U6zWAI2jUbhkdI0R6c0RaifzfofVzbSpAunj8uckZTCpaLRHZK9Wg3ATWsET8A8esJIJtOO9lu5nNWpcTO1nd8NjXIf/7IVOOr8zrMJQinykPtpur0reUM4Qg/bDxdJLIyfni7BYt9zvQKOvOowLqhUToT3y+kfu2Q1odn0Glr3/s3SV5Urff3eJyIU/fFTpPBpmhdQH2XGZwvwF0cAEMN3EOvfMmHexo9wJNEsZRUfUKi8i1I0S+2onKzDZ6FR7AXFzRf/FqaOMM7D7SLFPQfH9m+r4T+CRr1IAFH7q89xbT3r1vuA0DQjmmlRtyGXZrEyje2Ht7k7XosuJ9XbL9XQRkS3CBLalXryUppE+GY8VFOIV/CszBv0mMlgJwgLRA4HXFw28iUbXnhw/Vg1ekpX18eqKhjsc2O58wJ7/Dg/3k4ZUJVYpRYvJvqzk1hLi3lgN2K9LMFrKH1UECk7YIXZaNVwNkcNf0UJBQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61613a93-4874-4cb6-f3bd-08daf983ad79
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2023 18:41:56.7830
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p2S0rj2jvYyiQpP7rgFxaH0vReJDY6CxcXJPRXHeLE8WFS9rHeiLjGp3e2hSYoNfZdCCEmPRjYqbG8mBnHeD7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4992
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-18_05,2023-01-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 suspectscore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301180157
X-Proofpoint-ORIG-GUID: jHbqP02fOsCpCIoiRvGemjqfztpBdf3N
X-Proofpoint-GUID: jHbqP02fOsCpCIoiRvGemjqfztpBdf3N
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 18, 2023, at 12:18 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Wed, 2023-01-18 at 16:48 +0000, Shachar Kagan wrote:
>> On Wend, 2023-01-18 at 18:45 +0000, Chuck Lever III wrote:
>>=20
>>> On Tue, 2023-01-17 at 15:22 +0000, Chuck Lever III wrote:
>>>>=20
>>>>> On Jan 17, 2023, at 10:16 AM, Jason Gunthorpe <jgg@nvidia.com> wrote:
>>>>>=20
>>>>> On Tue, Nov 01, 2022 at 10:46:45AM -0400, Jeff Layton wrote:
>>>>>> The filecache refcounting is a bit non-standard for something=20
>>>>>> searchable by RCU, in that we maintain a sentinel reference while=20
>>>>>> it's hashed. This in turn requires that we have to do things differe=
ntly in the "put"
>>>>>> depending on whether its hashed, which we believe to have led to rac=
es.
>>>>>>=20
>>>>>> There are other problems in here too. nfsd_file_close_inode_sync=20
>>>>>> can end up freeing an nfsd_file while there are still outstanding=20
>>>>>> references to it, and there are a number of subtle ToC/ToU races.
>>>>>>=20
>>>>>> Rework the code so that the refcount is what drives the lifecycle.=20
>>>>>> When the refcount goes to zero, then unhash and rcu free the object.
>>>>>>=20
>>>>>> With this change, the LRU carries a reference. Take special care=20
>>>>>> to deal with it when removing an entry from the list.
>>>>>>=20
>>>>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>>>>=20
>>>>> Our test team is getting crashes that bisection pointed at this=20
>>>>> patch. It seems like there are multiple parallel crash reports so=20
>>>>> the whole thing is a mess to read:
>>>>>=20
>>>>> [  875.548965] BUG: kernel NULL pointer dereference, address:=20
>>>>> 00000000000000d0 [  875.548968] ------------[ cut here ]------------=
=20
>>>>> [  875.548972] refcount_t: underflow; use-after-free.
>>>>> [  875.548992] WARNING: CPU: 4 PID: 12145 at lib/refcount.c:28=20
>>>>> refcount_warn_saturate+0xd8/0xe0 [  875.549851] #PF: supervisor read=
=20
>>>>> access in kernel mode [  875.550158] Modules linked in:
>>>>> [  875.550752] #PF: error_code(0x0000) - not-present page [ =20
>>>>> 875.551269]  nfsd [  875.551878] PGD 0 [  875.552069]  iptable_raw [ =
=20
>>>>> 875.552677] P4D 0 [  875.552824]  bonding mlx5_vfio_pci [ =20
>>>>> 875.553095] [  875.553255]  rdma_ucm ipip [  875.553525] Oops: 0000=20
>>>>> [#1] SMP [  875.553733]  tunnel4 [  875.553941] CPU: 0 PID: 12147=20
>>>>> Comm: nfsd Not tainted 6.1.0-rc7_ac3a2585f018 #1 [  875.554109] =20
>>>>> ip_gre ib_umad [  875.554517] Hardware name: QEMU Standard PC (Q35 +=
=20
>>>>> ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org=20
>>>>> 04/01/2014 [  875.554656]  nf_tables vfio_pci [  875.555508] RIP:=20
>>>>> 0010:vfs_setlease+0x27/0x70 [  875.555695]  vfio_pci_core=20
>>>>> vfio_virqfd [  875.557015] Code: ff ff 90 0f 1f 44 00 00 41 54 49 89=
=20
>>>>> d4 55 48 89 fd 48 83 ec 10 48 85 d2 74 06 48 83 fe 02 75 1f 48 8b 45=
=20
>>>>> 28 4c 89 e2 48 89 ef <48> 8b 80 d0 00 00 00 48 85 c0 74 2c 48 83 c4=20
>>>>> 10 5d 41 5c ff e0 48 [  875.557209]  vfio_iommu_type1 [  875.557406]=
=20
>>>>> RSP: 0018:ffff88810378bdb0 EFLAGS: 00010246 [  875.557634]  mlx5_ib=20
>>>>> [  875.558446] [  875.558628]  vfio [  875.558862] RAX:=20
>>>>> 0000000000000000 RBX: ffff88824866c000 RCX: ffff88810378bdd8 [ =20
>>>>> 875.559006]  ib_uverbs [  875.559092] RDX: 0000000000000000 RSI:=20
>>>>> 0000000000000002 RDI: ffff88812560a200 [  875.559218]  ib_ipoib [ =20
>>>>> 875.559557] RBP: ffff88812560a200 R08: ffff8881da5ecf00 R09:=20
>>>>> ffffffff824064e0 [  875.559704]  mlx5_core [  875.560021] R10:=20
>>>>> 0000000000000000 R11: 0000000000000000 R12: 0000000000000000 [ =20
>>>>> 875.560165]  ip6_gre [  875.560488] R13: ffff8881da5ecf00 R14:=20
>>>>> ffff888110e62028 R15: ffff888110e621a0 [  875.560634]  gre [ =20
>>>>> 875.560959] FS:  0000000000000000(0000) GS:ffff88852c800000(0000)=20
>>>>> knlGS:0000000000000000 [  875.561108]  ip6_tunnel [  875.561432] CS: =
=20
>>>>> 0010 DS: 0000 ES: 0000 CR0: 0000000080050033 [  875.561554]  tunnel6=
=20
>>>>> [  875.561928] CR2: 00000000000000d0 CR3: 00000001ca27d001 CR4:=20
>>>>> 0000000000372eb0 [  875.562084]  geneve [  875.562349] DR0:=20
>>>>> 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000 [ =20
>>>>> 875.562493]  nfnetlink_cttimeout [  875.562822] DR3:=20
>>>>> 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400 [ =20
>>>>> 875.562962]  openvswitch [  875.563292] Call Trace:
>>>>> [  875.563298]  <TASK>
>>>>> [  875.563503]  nsh
>>>>> [  875.563839]  destroy_unhashed_deleg+0x58/0xc0 [nfsd]
>>>>=20
>>>> We are aware of this failure mode. Actually this started well before=20
>>>> that particular commit.
>>>>=20
>>>> Our problem has been that no one has been able to provide a reliable=20
>>>> reproducer, so we can't figure out why it's happening. If you have a=20
>>>> way to reproduce this failure reliably, can you capture a vmcore or=20
>>>> enable KASAN and get a little more information?
>>>>=20
>>>=20
>>> It's possible that this crash may be related to the problem that was fi=
xed here:
>>>=20
>>>   commit 0b3a551fa58b4da941efeb209b3770868e2eddd7
>>>   Author: Jeff Layton <jlayton@kernel.org>
>>>   Date:   Thu Jan 5 14:55:56 2023 -0500
>>>=20
>>>       nfsd: fix handling of cached open files in nfsd4_open codepath
>>>=20
>>> Unfortunately, that hasn't trickled into v6.1 kernels so far.
>>=20
>> This commit is in my working tree, but this commit doesn't fix the issue=
 since I still face the crash.
>> We are working on v6.2-rc3
>=20
> Thanks for testing it. That patch fixes a real bug, just not the one
> you're hitting apparently.
>=20
> If you're comfortable working with bleeding edge kernels, you may just
> want to pull in Chuck's for-rc and for-next branches.

Stephen and I renamed these yesterday to nfsd-fixes and nfsd-next,
respectively.

nfsd-fixes was pulled into v6.2-rc yesterday, fyi.


> Those have a few
> other patches that I wouldn't expect to change this, but might still be
> worth testing to see.
>=20
> If it's happening regularly, you could also try disabling leases on the
> machine, at the expense of some performance. We suspect this is related
> to delegation handling, but we just haven't been able to nail it down
> yet. If you do that, and it seems to fix it for you, let us know as that
> would be an interesting datapoint.
>=20
> Thanks!
> --=20
> Jeff Layton <jlayton@kernel.org>

--
Chuck Lever



