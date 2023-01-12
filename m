Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 154E36668F7
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Jan 2023 03:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234628AbjALCi4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Jan 2023 21:38:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235069AbjALCiz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Jan 2023 21:38:55 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069644086D
        for <linux-nfs@vger.kernel.org>; Wed, 11 Jan 2023 18:38:53 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30C11etf003828;
        Thu, 12 Jan 2023 02:38:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=EITRWm+FxaCnkxZcVcFKA1LODRduksNLr+L89gbHH7E=;
 b=a3sGNapMSfWn1MxTw7NF0uhIwFhbmgAss0KBCbjr9Q7h/73kUvMzhLCCdWNkcVXhIRw3
 nyjl1eRbNtGkM0XTvX3g7Blx/dC6R3+CMqvcgAmEBkOrZzZ4bvT+zYSfC+1rQ3KonKPR
 GELimmvoqVcFG2yin6YGmnIqYTM+kDfYGg6mhTfDXBNyTBZQWL7BY6iXIuJoNO52KSdN
 2GfsPfsF0hSVzspctFJyZRJG7wq8aZdpYCEy5kxBZ7vnksI3WGdgB2pu7xq5JV0p4HZQ
 d8MSGE43v4+q7MYQy6NT7bfsOMkxXZ5S0o7Gzum4pDtlxBzvbWFzvM2k9cvV/LCQ8LJA +A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3my0btsc74-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jan 2023 02:38:48 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30C14a5O016107;
        Thu, 12 Jan 2023 02:38:47 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n1k4q3yqd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jan 2023 02:38:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R8IaRQxntMpGG5xPBOSMhbfGPNLHkAup8gESoR4SntYhbzuQDABDhEapuHmKeiV1e3eOliPxowsQhdVdJH+um7mJEgJkCm3lBqqkSHePOSTJRiMTSc78MtSkLZbxYt0oMI1cM/5MSFi+vD9n1/177KFmuS7biBFjcHygluNJTWDqrKPJjaRw3m2zdqtbg1daqAYne9Bjw82QTtdHMvvINL63OSsTH5ScnQdcTiYTGr61ycDFt0kPenTdNqaFz7Yt7E0QZtGQsOIgfEQJBXRGNEwL5f4HqA0afxtttj0qghpheTPCNZk8BKFWrJeC8KflUChPZ3CO9BEd5tS34BtQAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EITRWm+FxaCnkxZcVcFKA1LODRduksNLr+L89gbHH7E=;
 b=CNvLuw+XryQgEmIvdU1ppyezOpLvl/vaf8j67rzUCyLjFHCw8F82cMrJ8ELx+8ZCZhJAnawTZK88AZCuWqdZc8qyp3L9Gug3VeUGZy2Ryj5yNvFNHUakU17zN4VWoecFFzXk8NuuxdwfZXLV5UWXjEvsAAjlcpOj17U9INfOEQ2CDzS+zIj1f4tEJ15LrLnt4YB7736MBWV417DTO0LvH8AUqhjQG4lhwpHvU902PR3mcCsyX4k8CY3fXsm36JseOS51VhYBmAaiKJaCBb7V9fct1/kjQkqh4+MLqUnI5gtvgT7BMryvfRHR32LIErLX+XLwMY+ab+YWWDyFSBbxOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EITRWm+FxaCnkxZcVcFKA1LODRduksNLr+L89gbHH7E=;
 b=oVb+IMx4Vr1A0PwSbsniDePWv0Uo4EBNpxNke1sMKW00Q0PQgKfmtMa5RrBWNoAVGPZFF/wEyy5l9N6d0f4aDzb3xTXqy1BZvr9rn1bNE/P5ryLu9/VTbxygQP6xPgVXOEm2SnTGbHqZiiY/GAWeYdxRxd/VCzxY09Gopw+kUek=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY8PR10MB7169.namprd10.prod.outlook.com (2603:10b6:930:70::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Thu, 12 Jan
 2023 02:38:45 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9%5]) with mapi id 15.20.6002.013; Thu, 12 Jan 2023
 02:38:45 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     Jeff Layton <jlayton@kernel.org>, "efault@gmx.de" <efault@gmx.de>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] NFSD: register/unregister of nfsd-client shrinker
 at nfsd startup/shutdown time
Thread-Topic: [PATCH v2 1/1] NFSD: register/unregister of nfsd-client shrinker
 at nfsd startup/shutdown time
Thread-Index: AQHZJfm5Qo4CjX6HJU2fgUGjdpWLW66aEgeA
Date:   Thu, 12 Jan 2023 02:38:45 +0000
Message-ID: <3D2DACB5-1D69-4DA7-9CE3-8730E2ED1258@oracle.com>
References: <1673468229-20039-1-git-send-email-dai.ngo@oracle.com>
In-Reply-To: <1673468229-20039-1-git-send-email-dai.ngo@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CY8PR10MB7169:EE_
x-ms-office365-filtering-correlation-id: 0ed9fd3b-16f4-48ad-1f5f-08daf4462072
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NnAl2M8nTz/GbdnNNC/RPRHjoSRmM4KUooAQS5tvKJVLroZKbZgutmoF8k+CmcC7UAn5letmBc6bFp2CxaxOXpMpWrFxopTFMMKX8kJqRdXRFiq1BuqXimcdnft7DNCIeU67mnkAmoc+iZhhyGaQw7Aw2L7cMzChAcpnld3u2lgAPpyvn6oD4mF3pUdysm2k6l/9t2H1DLWu53pqhVm9c4HNcpvyJeWOu903KUhlpvBezBUc46VxSvLXndQvzA+i5o5cZoxuHEI/oP6ssd3JztEe83oOMbO7sKoTSgKum8kfRL/XIhHK4FISj0LvUDVxfm2IoqXst+M8pj/5NnMLUkjP+x3reSQKywY94/cgzs7c+7skwjJ0P8jGtwNfANP8CD1maifi+fzIxuznsWQEGsS7VJ3gQr0dyvqoImNsP4By/v+UnqWAHT8uMQgH4fW8LuVed1PQMLAXmJZ307Fh+z21Eq/IvHP0vjPAAZaKFNPTmGWEjZRQVJiWHVEatt2032bpgChgngDPvEszI/qWkmTWtltygpYtBahQ4ThOpyNzOnKJBxkyfhRv5TBGDnYgXjQK2nEHXoyAUy3vHl8LG2JQipIrXeZubcXLx6q6ijBQDJqj49sTYbauYyQoFG4xRDvm5ShPwUFR+xtpcy0xu3qBsgYOd/A93yrkhkQy1j8VIVyaNsYs027j9OUaG1Q76vRh7wtVlzoPbAG+lDKk1SGAEYLApS6CdAQmm1Abni0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(396003)(39860400002)(136003)(366004)(451199015)(2616005)(54906003)(6636002)(478600001)(6486002)(36756003)(71200400001)(2906002)(38070700005)(37006003)(66556008)(8676002)(6512007)(4326008)(41300700001)(38100700002)(316002)(6862004)(8936002)(66946007)(5660300002)(83380400001)(33656002)(6506007)(66476007)(86362001)(66446008)(64756008)(122000001)(91956017)(186003)(26005)(53546011)(76116006)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Q9uVEydwLKvMVxM+CpmOcMLiuOoilBus/sPyNNdfug3tB4Pcqky7N45bMR7m?=
 =?us-ascii?Q?RezbZB31OltHlznDMHLy7AyTmQRNjTCYsOyDny6NzyvGag41oBnP1MyNdk0I?=
 =?us-ascii?Q?A0ofbzJElMOlGWw42aGFz3AIhRE5FAu4TPPSyjEkOQFzoXpn3tyNxO3OTCEF?=
 =?us-ascii?Q?kaApUV1bOrXrvkYfs7EwHh7lQimv00B62HdTjxaVTJqtWsUVLhgBCWApjsuG?=
 =?us-ascii?Q?in3LDsR/MhM7LT+OdqlK4VDdg/2ZDmfWPYQj840r4k8WPG8uY8t1TDWm8KWJ?=
 =?us-ascii?Q?z2/k3WHIokHui4HhzeHs4EvHXtzgjH07eKpbWEaEsX13O3vK7c2BOE+Z0OLa?=
 =?us-ascii?Q?qoue9OLZof2ypgwe30u48fGeFC4agL6MPFbrRBMF6AOj7lobRnDIfnW7f8Wn?=
 =?us-ascii?Q?odzEKgy0X+wPdTlSfSUTyIxAxztJBmNBmN2oGNdfSukBmJFbbI05Ubb9uSPO?=
 =?us-ascii?Q?f7EYEvjvq9MMxQ825BJv9UETqLig5PmZBjfMoGDZNLU4LvASYwL1xaLQHiSw?=
 =?us-ascii?Q?pRj09nX0+RBEA8ylEcNcdqvvsc19l41QCWIjwXbJGSFtqZ3k8j7vd/SaaiPy?=
 =?us-ascii?Q?3yM1qhtyRUsERq7OU4UJmfzDwJiEdc2mHntR9W7jbzAl+jHTVa6ttugX4JyW?=
 =?us-ascii?Q?2QbUXf4iK+VAFAzT+fzC4eyU7H0la8gIOaJoYOtenm3w3oZlO16NmgeWqIqH?=
 =?us-ascii?Q?DxdmHj3DdkGXNDi110H+DpLyvyz8S3AVOJ7Sh8SbsjbB1UYr3vRh7PDcknHE?=
 =?us-ascii?Q?8Fs1IfzSYH38B+A2Ena5cMUwe4dVIO10Ss2IDIP/RLUJHXIv5vuU08McSQPj?=
 =?us-ascii?Q?E3dA9UgnRQ9zPu8X7Rk+I0pHcaqeNZu5sAKvUz2Z0JPgodn2W0f0+O/WHDs2?=
 =?us-ascii?Q?PcR0u9MDp5NikBiINNr1viMmvob+WbziNuHBwsyh8TWxR9m3V91QewS+WyZj?=
 =?us-ascii?Q?WwNp/MLtJpmGSHfGHgiX8xuU+j4bNS+MCa3SaIdqE87emb3abcWhRGaEhSsg?=
 =?us-ascii?Q?YHQuGqdDehoZY0XWflpk2rqZ06m17i5tbafXnBU2TR2EW4yz5pbUGj/IxFrn?=
 =?us-ascii?Q?Ka5hZlmYZaNW9fEf1OxW7Bl1DiB7pWhW82pM9oXSLSuvsqJxEOCHIu3CdRac?=
 =?us-ascii?Q?gC4nN3UNw8aJHFhmjNbbyePTyJ3N5h3pYcyK6DEPwMCYzKeIFXVH9u9tL4lr?=
 =?us-ascii?Q?abJ5exf2H/YijT607JLLtQVuX5Lzbmlj7NMoelSBq/inMjwFhGy2ywucYMvT?=
 =?us-ascii?Q?Nm7Re4cBnk7CWl/BFiYII2QYepQCZqOgvYpx+4sBtmqz+heF6Sce96oDL799?=
 =?us-ascii?Q?RXm9DBzu9hr2l/ceKRd2ooBWflQMU3ayO7iA86UGKzi9NZRGrSVd1V/lBT13?=
 =?us-ascii?Q?cT2X3YdM+QGdje0q92Zu2tQICE9miJjapV3rRfhiNOR2slKlsK68WX7qxfaH?=
 =?us-ascii?Q?d5pgAlNIW3Pdzof4U8jG2T3FdY1cWoRnufMwR9sb9Nq7nrQp+3YNz/iS0b3z?=
 =?us-ascii?Q?DYyvTvMrT1tAQkccPnuoj3f/Z1/txO+Z/1F6ataDFcGJLiWMv4RRhNjQVhUb?=
 =?us-ascii?Q?QQcazWoTObYiz6kdcU0bP+g0cBTW8MwuR3tGSa40XkbTyl9VyLoPjDCN5ZbG?=
 =?us-ascii?Q?Qg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F41E97BC5C34DB429C74B0DF99AE7CD2@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: VGmBx9ZhY1CzUg6yAcD5KOXXC84JGO3lNzO9dhsvf1MqyoAcHwU5B4hF/Zr/01GEfQmPX2P7iYBXX3ztM2kpoRQns3JBivUZosOybGwqXFrqeKNIAF+AwfPRCOHivzvh0xszIqU2iNl1B2Z4TgwuzMF6DCybGizrPN4FIOnC/QKqKE62hs8kThsbufzUhdtTSpahORTXZ/pkP4YyPyHHxjX6DPHMvgz6sVNHUkM2DX7mPXnV5tAEzw84rfi/rGh8q45guPWKiXcj/iSWJwUD4s/yDsCNyR/OxM1ch0JX5DLO9YHqKGpYUnIbhVnbxTn39kNjcnzNPE4x70zIkNUd/EglwjUy4Cv6wmqA8flKT9to0kh33Z8SMnG/vgQuFqa1XEz6CZc1I9f9AfPU47qUqFq26+utXXMkct9YocvEBHNLaqn6TuEMWPd2Oo0X0EVDVnAMqnO8GcX2APM1WZK9zhhuhhMeUVTqP4jkc5ZfjBwsy3Urs6fstvkOZ8kOBpirjvOnzjCCPfcbg7EMlulM3R2kAty78N3hCwkimwQDmbCkHYOsWc9LJ/nJsO136oSHHNUcYQfzHnXmw9ZQDQK0emKoMlwp7MY76Y+l2o2hvG5KjEfUajUY2BXd0JaPcvdgYr3BBzfXTfR4cRQA7QTw5EWQSkSFpJNNkk9aeAG1FOAyaQV0PSCgTMdPCe5t12vlazTVaffeXL2FhjIVWU3+5MTkqAa11hOihf1PypOkyUwg1ZrV12mj+iRP8QZHD8HlQ6oRXmFis99KLGEX/j2eeb+XK2t7SY3M+rNWjNWkJFWrYUJPwlfeR5hHjzalVLzJ
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ed9fd3b-16f4-48ad-1f5f-08daf4462072
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2023 02:38:45.5428
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sKo82GxGAMTKJFxKF0AToXJobWV+kx0cNuQRsl2i+lI/dqSA6Y7Ov5iMRj40cLNkwftUTFzbyFFMHUb/M9bP+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7169
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-11_10,2023-01-11_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 adultscore=0 spamscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301120016
X-Proofpoint-GUID: IXls9hI_oGqU4v14I-9lz8MBtCGBs595
X-Proofpoint-ORIG-GUID: IXls9hI_oGqU4v14I-9lz8MBtCGBs595
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 11, 2023, at 3:17 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
> Currently the nfsd-client shrinker is registered and unregistered at
> the time the nfsd module is loaded and unloaded. The problem with this
> is the shrinker is being registered before all of the relevant fields
> in nfsd_net are initialized when nfsd is started. This can lead to an
> oops when memory is low and the shrinker is called while nfsd is not
> running.
>=20
> This patch moves the  register/unregister of nfsd-client shrinker from
> module load/unload time to nfsd startup/shutdown time.
>=20
> Fixes: 44df6f439a17 ("NFSD: add delegation reaper to react to low memory =
condition")
> Reported-by: Mike Galbraith <efault@gmx.de>
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
> v2: reword change log for better description of the problem

Hello Dai, I've applied this to nfsd's for-rc, and expect to send
it along to Linus in a few days. Thanks for seeing it through!


> fs/nfsd/nfs4state.c | 22 +++++++++++-----------
> fs/nfsd/nfsctl.c    |  7 +------
> fs/nfsd/nfsd.h      |  6 ++----
> 3 files changed, 14 insertions(+), 21 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 7b2ee535ade8..a7cfefd7c205 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -4421,7 +4421,7 @@ nfsd4_state_shrinker_scan(struct shrinker *shrink, =
struct shrink_control *sc)
> 	return SHRINK_STOP;
> }
>=20
> -int
> +void
> nfsd4_init_leases_net(struct nfsd_net *nn)
> {
> 	struct sysinfo si;
> @@ -4443,16 +4443,6 @@ nfsd4_init_leases_net(struct nfsd_net *nn)
> 	nn->nfs4_max_clients =3D max_t(int, max_clients, NFS4_CLIENTS_PER_GB);
>=20
> 	atomic_set(&nn->nfsd_courtesy_clients, 0);
> -	nn->nfsd_client_shrinker.scan_objects =3D nfsd4_state_shrinker_scan;
> -	nn->nfsd_client_shrinker.count_objects =3D nfsd4_state_shrinker_count;
> -	nn->nfsd_client_shrinker.seeks =3D DEFAULT_SEEKS;
> -	return register_shrinker(&nn->nfsd_client_shrinker, "nfsd-client");
> -}
> -
> -void
> -nfsd4_leases_net_shutdown(struct nfsd_net *nn)
> -{
> -	unregister_shrinker(&nn->nfsd_client_shrinker);
> }
>=20
> static void init_nfs4_replay(struct nfs4_replay *rp)
> @@ -8077,8 +8067,17 @@ static int nfs4_state_create_net(struct net *net)
> 	INIT_DELAYED_WORK(&nn->nfsd_shrinker_work, nfsd4_state_shrinker_worker);
> 	get_net(net);
>=20
> +	nn->nfsd_client_shrinker.scan_objects =3D nfsd4_state_shrinker_scan;
> +	nn->nfsd_client_shrinker.count_objects =3D nfsd4_state_shrinker_count;
> +	nn->nfsd_client_shrinker.seeks =3D DEFAULT_SEEKS;
> +
> +	if (register_shrinker(&nn->nfsd_client_shrinker, "nfsd-client"))
> +		goto err_shrinker;
> 	return 0;
>=20
> +err_shrinker:
> +	put_net(net);
> +	kfree(nn->sessionid_hashtbl);
> err_sessionid:
> 	kfree(nn->unconf_id_hashtbl);
> err_unconf_id:
> @@ -8171,6 +8170,7 @@ nfs4_state_shutdown_net(struct net *net)
> 	struct list_head *pos, *next, reaplist;
> 	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
>=20
> +	unregister_shrinker(&nn->nfsd_client_shrinker);
> 	cancel_delayed_work_sync(&nn->laundromat_work);
> 	locks_end_grace(&nn->nfsd4_manager);
>=20
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index d1e581a60480..c2577ee7ffb2 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -1457,9 +1457,7 @@ static __net_init int nfsd_init_net(struct net *net=
)
> 		goto out_idmap_error;
> 	nn->nfsd_versions =3D NULL;
> 	nn->nfsd4_minorversions =3D NULL;
> -	retval =3D nfsd4_init_leases_net(nn);
> -	if (retval)
> -		goto out_drc_error;
> +	nfsd4_init_leases_net(nn);
> 	retval =3D nfsd_reply_cache_init(nn);
> 	if (retval)
> 		goto out_cache_error;
> @@ -1469,8 +1467,6 @@ static __net_init int nfsd_init_net(struct net *net=
)
> 	return 0;
>=20
> out_cache_error:
> -	nfsd4_leases_net_shutdown(nn);
> -out_drc_error:
> 	nfsd_idmap_shutdown(net);
> out_idmap_error:
> 	nfsd_export_shutdown(net);
> @@ -1486,7 +1482,6 @@ static __net_exit void nfsd_exit_net(struct net *ne=
t)
> 	nfsd_idmap_shutdown(net);
> 	nfsd_export_shutdown(net);
> 	nfsd_netns_free_versions(net_generic(net, nfsd_net_id));
> -	nfsd4_leases_net_shutdown(nn);
> }
>=20
> static struct pernet_operations nfsd_net_ops =3D {
> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> index 93b42ef9ed91..fa0144a74267 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -504,8 +504,7 @@ extern void unregister_cld_notifier(void);
> extern void nfsd4_ssc_init_umount_work(struct nfsd_net *nn);
> #endif
>=20
> -extern int nfsd4_init_leases_net(struct nfsd_net *nn);
> -extern void nfsd4_leases_net_shutdown(struct nfsd_net *nn);
> +extern void nfsd4_init_leases_net(struct nfsd_net *nn);
>=20
> #else /* CONFIG_NFSD_V4 */
> static inline int nfsd4_is_junction(struct dentry *dentry)
> @@ -513,8 +512,7 @@ static inline int nfsd4_is_junction(struct dentry *de=
ntry)
> 	return 0;
> }
>=20
> -static inline int nfsd4_init_leases_net(struct nfsd_net *nn) { return 0;=
 };
> -static inline void nfsd4_leases_net_shutdown(struct nfsd_net *nn) {};
> +static inline void nfsd4_init_leases_net(struct nfsd_net *nn) { };
>=20
> #define register_cld_notifier() 0
> #define unregister_cld_notifier() do { } while(0)
> --=20
> 2.9.5
>=20

--
Chuck Lever



