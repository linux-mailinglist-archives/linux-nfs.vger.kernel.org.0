Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1662775FC77
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jul 2023 18:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbjGXQpe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Jul 2023 12:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjGXQpd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 Jul 2023 12:45:33 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D0B10D3;
        Mon, 24 Jul 2023 09:45:18 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36OFO91u011910;
        Mon, 24 Jul 2023 16:45:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=qTH6r4qN83JctjR0dEmGiRsex9Sdwf/FzEzcZB3NoXM=;
 b=YeA9ZOtjMv5chsPZ48GqFjv6UJGCVbFpQyJLj1mk/Axwy5ABmb++itZSuO60SsStlP3G
 5nfainn8OMX0hZ+MqGrgDP2/cFEgGrqHVinnaUqQasBbFrymbB7Rn5zU3iytYWAzRVaU
 9+M2sqYYiy856K6zeCaOZCe5beohmC24DXz6bZsM0PKw1il7gf8ftkBcU+Un5AwM1MuP
 o+qUFIROnpW43l9C7yYafYGIzgjQcy5h0WY/9QczclAdTnlxAUKqjO3QBzLnzisES0hY
 PNgTo8MZeERT3hd19+FLnCx4PUvZjMwBD9UoEbrSJd/5JFPMiImFv2FwXeVhpJ7cVy4C 7g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s07nuk5e9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jul 2023 16:45:08 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36OGWbsa003840;
        Mon, 24 Jul 2023 16:45:07 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j3nv77-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jul 2023 16:45:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FEmmhQaTa2M/wgarYWPiKPtFQaDrreENiWbqhai3IbaGxmr20smxUd3C7rDG8ufutlWI22thGltq22at2tnqrI/3RP3XBKB6Rq8lrFiaeN86pHOVh5RykNfNYnXPmuolv1w+DGrkoaF9dnXS9tMTmlAh2P+50I/aZ44xWBageifupEWzWkYROSDwhctegfhMcmRgi7gxWZWYWzG4kHryWQHN0L6nSkELFjyRbFdq4aT6n8bk8b7gG0WUQw/A/LjM2zcuS7oC60GtCOLg8V6MQ3DgLCgKEiLnjoTCHwqqzBtCvL6/PtR5aL8evj3Ed/5V0xo8a9iCyLWkfPjrc7MEvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qTH6r4qN83JctjR0dEmGiRsex9Sdwf/FzEzcZB3NoXM=;
 b=SpZeZGo0f6fq1shMtAm6kLWSnwp4mL0H77XLpx98wxY2Qy+lu9NdRBTkCYZDQeZjIygRP/pEZu692XGevVeER9rlSnDFowEsD5GJ5pmh6WhNvLAF7SF47PazQhNiqRplzSGtKW/VIjAvXpovGYw7bLTmFtx3C8s/Xs8gyt5zNNVkNtQ0acDVXXNHx8kx5t/BtaCxHK7Yf5gGx0XdOnLAahDa5lbyMHupvvGFJra2frezg4FNX0CfRkvOsmuuRbwDdnacznCIBo0CepZtsTi5wUC1cys7j7bg6+PCmNXRv923NV/az7zeQ93w80l0dpIMp3OKMoDcLCT+sYsm2E8yUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qTH6r4qN83JctjR0dEmGiRsex9Sdwf/FzEzcZB3NoXM=;
 b=w0i01/32nBP6Qo5iJm6wdy2f5hyiMLN91JdTtg1AAtfAb5eMLToC1IVqfWN1RakO/Xlxd3TJ+/evmWK7XTSeOkK0v+YPAq9mzr+e00Dz1tQjmTa4cX7SyKcJt/cYO6tH3NtuXWXBUQ0nlR3DZSiMlofLP1S73zMOGp2YgAjck+4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB7410.namprd10.prod.outlook.com (2603:10b6:610:190::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 16:45:00 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 16:45:00 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] nfsd: set missing after_change as before_change + 1
Thread-Topic: [PATCH RFC] nfsd: set missing after_change as before_change + 1
Thread-Index: AQHZvj6o6m/jjpOmRUW/EQgAVqDhPK/JCFsAgAARCoCAAAZvgA==
Date:   Mon, 24 Jul 2023 16:44:59 +0000
Message-ID: <16201902-595B-47F1-B251-927C24E7A42D@oracle.com>
References: <20230724-bz2223560-v1-1-b6da868c0fc6@kernel.org>
 <ZL6W0GqBSdlvVL2Y@tissot.1015granger.net>
 <969a2ddc66df3ba05952fb14352ccee08bd84149.camel@kernel.org>
In-Reply-To: <969a2ddc66df3ba05952fb14352ccee08bd84149.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH0PR10MB7410:EE_
x-ms-office365-filtering-correlation-id: 57ca3ad2-a2a4-4e57-a251-08db8c65521b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zZGC/fkSdjMN5K6oKkX8fHoJeqnul3gJkWk3C0Bm5hoaox0Otd6TpQFUh+mfY6/4o/CTtpLhZoq3uRJJoQI2hmLD3JXHVp03MncRI0rUpYXxZRzbfUt3X+xQLLYbLJ99cJCBUM6A8xlOndNI5f1aZ8/BJkS2kI1vAnBMHQXncSDb6PJzMfJpzaaMw/JNYeYAj0ioI8wEOwhlzP9eQwiXZ4aG/dKEoq9tRzwbiQifZoVbVWpClPqxQN4DoiT7KO7EXh6KwTujuOVDwet0wYjhONQkbvCkfV5oSS94PFZGlNpL1XQnJWJCOsoGmy3oqiOViQCdRnUsUKbtvkAp46/VdvC6vyBxPJJxYOs9xs5QN/YRqaaJVYoESagif2P75yhX8j2+kT+3dnejUam/Y+EXuJIIlg9O1QjiFc8Uai0OO+SsWfhBWeoIejGKuhBs8/YMebIct1wcxgAjpTIJ+P+gd59h+DKra6ngBkya6D0QDp2d+Lq1fQBl16Ufyq6Uo7Tbm8hFUSrtxXmTA0WOdQGGCueMviQkdsFgTGbe/MLmwGoKMFSY/moMqQN74oN/oZt5AJZNuVvBrQz/VusG5CA2GmiYpWUnbDJmwknETXP7qaBm5GVlZwErSceafadDxCql0IoKQX1yJnaPzqVec3P3EQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(366004)(396003)(346002)(39860400002)(451199021)(8936002)(8676002)(5660300002)(41300700001)(316002)(2906002)(66556008)(66446008)(66476007)(64756008)(66946007)(76116006)(91956017)(4326008)(38070700005)(53546011)(6506007)(26005)(38100700002)(86362001)(6512007)(54906003)(83380400001)(6486002)(6916009)(478600001)(33656002)(71200400001)(122000001)(2616005)(36756003)(186003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EO7j8mZb8cg1Rik6quuP2rFHtSYqRZ63r2AafpC7Rs/Kw+yPkZPfCsET2oBt?=
 =?us-ascii?Q?5bvhwER8LJ+hPJkD/JoTSibhTLnqydBBgwVcWlSynJ0eGOVzkQmzvarLdF6W?=
 =?us-ascii?Q?BGDwewwI9Fyq6RwgAV4MHo66rbXL1WG6LXcwdlf0PP2S4EmK0yItI5BvXUg6?=
 =?us-ascii?Q?vy0nfYY+LPvdByTj+65Q+QVUrTmUtGMoROYzplY8qI5krKk5JrB61S4LY1mR?=
 =?us-ascii?Q?TA5u7opUsmIMza4Th69s2gegDkVetjo54Jbv0RIb9SUpL3Gx5G+IC4jjdQIP?=
 =?us-ascii?Q?y/8lLDt1Sf/F0E8KB3eFb/sbLmVKn2Nr+eSQbvJSO3D9GEyS4a8+EQ3jEugW?=
 =?us-ascii?Q?+KRoSswAKFIPJNOTcIFj1h50y2CmdyHEL/fIMjBWrfVvSe7ZfqdPqi59YbZu?=
 =?us-ascii?Q?pd2JkfY5HaPAy+a60UbPWqCKXsINq6O9kjEHWde6o+nOnyNoPujiwN1Cuep9?=
 =?us-ascii?Q?2sEL2MeqD/8ykKhW0YBFgk3ticwJWNmmQbUVtKpcrq9pdhsKVJGOaRySx/De?=
 =?us-ascii?Q?Kar4l8rOeQNjKKNKF6Wr49hSFY/NZGVJSNhf5DooUDN5hS8yz2wcd2tpzQXi?=
 =?us-ascii?Q?W0WCrHViHcz5DPNHjYETOr4VVOylp4BwRVmx7prdIsYyjDvz33Czl0nJtDuL?=
 =?us-ascii?Q?HqD6xaYX5ak4FlvyqVHh55lCDvCn1YYOufYMAw7RpPKQBE6b1zofky74A+SB?=
 =?us-ascii?Q?y/+INrTkVIEi+/AV68w0eApr1It+tLROBnKlTSYlljCaApIsb4fvvQpZDJ0Q?=
 =?us-ascii?Q?JJQwSDvqrNtFGKpNqHAakk7gaJQ7jbn/oInopO8sJJs606fe27VJT8i2uK1x?=
 =?us-ascii?Q?nLDiz476R0zPBeA3zalXzm62QJF/o1366qfleTxwoWLYfkIjwfuVF7r1UFj5?=
 =?us-ascii?Q?RIzt+I4PuK9UCtrymRb32Sb5osslp6y97yjlq9LWcxW9VO5WIopMyVdKy/Bg?=
 =?us-ascii?Q?8AIJWl0qXXbjsHQSpj674GnWn/4UsF/jMWFAKgfbFrlMaBl/pxQ3VAXoX7sS?=
 =?us-ascii?Q?x4hEG3MThtuiUIvNN5IXeYq7kkkdleBDmquCd/lorhuUhScfJz2clc2WCUeM?=
 =?us-ascii?Q?hlh1fpAZQAb4NBarhIgrgCXnje2G4bEOw2FHN1dyC0djJ5Ms9fMjeVud8+Dq?=
 =?us-ascii?Q?uwOeoWp+9l9WEHwI6oViS2jyHE7jJg1Ntl9majBxtbi2sgD8n17rF1ismAvh?=
 =?us-ascii?Q?oyH1hORBAfSwEQcDKaPthr0BxsnieHHrxZdbfHQqJAUYHyO96m51zkJ5Mrwf?=
 =?us-ascii?Q?CNVPrC4Meoc7qgHrgaSD5rzXPmWsgJ2NlNvb1QOPjK1Zk6p8iHrA5/kKLajG?=
 =?us-ascii?Q?gjmX/ScfzfvysFkCodLhcQsh4SAaYOuT5no03nUnzRyq9cnNKsykoj7ZXtQk?=
 =?us-ascii?Q?ZaxoiKw3yoroDaUctjyibaU/8guAFa610EPrH6ny7R0kh904YwbtLVHsKLhX?=
 =?us-ascii?Q?eAWRapRS4/TUAhIc13YAVrU4JPjgAWK4pkMrXbfgnKd9lNOELpSiIc8Nxey3?=
 =?us-ascii?Q?gxsXMtXk42YjHYhW/1Of7k34DSvN0yrpxKTSdPLHVCKka6+MV2DFnX2uoX5A?=
 =?us-ascii?Q?Z4zu8ADUCtt9VksKmn0Y8i7EMuRw7YinQBiWawe5rFz5Do0H8A3FVOW4r7Z0?=
 =?us-ascii?Q?Kw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <69CED5E787C9604A8EE9728B14851164@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: yTl3hgL2taNvzZfHzQoZ+B+f7Kg8wuXvurpGg9I9528+3OpYq0s+sJefZwwTsNj7TQ1aMG8p0Yg1xVUAdrly2PeSK91RE1U9S+rZjdV2Aw/mwg4BeXimroW9UJGnnwbRCWCXsbWCOrdEWmFQO/TF1YithLDMb+lo6tMxY0fbT26OEM8z5osQzsdEEtQ7yphdUpYS0tIVXhvvbFcXx83YD4ez7teleZyWEk1Bh4maJyzDebVNO62OX1Z/WPx1qIGF4dj04IbF0+sEDZOTNna7qRvkzIr/nTfOVtsijPQ5iPp54WAtREM+IWyoTY81SNLAIMi2sFIZyHE9WMqIuK2xHA98bCgyq6ubSFB+xTKkpH+HVSjbscXHpbkFfuvQGrcktmlAlyUTBeT3xPPVSQex4/Jhf1ZvkhzonebDUUajU96eU2t7G9TSQLEv2YxwPBsUI1n9aK2pctkB1egKJKoYGQNTjkwjcC1zol2O+k7eZfJrTJUzp/c4bXBkYqdw112DdByARPkwIUv6rt+kBuGxNnhbxg/mjJskqDxCue4o4bpwbh2qQtUDf/B9YP2TBMv/Aa3TsGMSugNP6L6pgnPBejGxRMzcJzaqDkBeIxX6QCDd+Sc545AeQTcWH3Rv93gvRg2IlhFknHqCPUXV10yMaVSlw8WW3C2c4fa3S05+9vK3E6BYq5u2bfY07hw+Sr2QLcc5ayVSV6ouPyZi5jg3pfJSvh/lxClM8qTky2CWwWQtGmPJpyoGxzTPaNP4L94C77rFC1vupeEBGGTE276q9MVvV3//+IJAJreR4mzZFLHzbvqBkotk1wqf5CgWfzgDdEJv9Wx9lwT2LI/JXIlQobMNmAOlAD/dWef0nWc1rmlWRkpufi99Ju/WTtSH/xYj
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57ca3ad2-a2a4-4e57-a251-08db8c65521b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2023 16:44:59.9630
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GWI7HmsYsCJvaCnRYQzlk9CVa2c0MxEMLREtbxo+/t/KBAzSYmHb/wDDaAMQasZ+wzvxVwCX/qA07nRaZTgFTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7410
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-24_12,2023-07-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307240150
X-Proofpoint-ORIG-GUID: CS0ZMd2tck1EzjAIr6xg8psdgsL-nFKe
X-Proofpoint-GUID: CS0ZMd2tck1EzjAIr6xg8psdgsL-nFKe
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 24, 2023, at 12:21 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Mon, 2023-07-24 at 11:20 -0400, Chuck Lever wrote:
>> On Mon, Jul 24, 2023 at 10:53:39AM -0400, Jeff Layton wrote:
>>> In the event that we can't fetch post_op_attr attributes, we still need
>>> to set a value for the after_change. The operation has already happened=
,
>>> so we're not able to return an error at that point, but we do want to
>>> ensure that the client knows that its cache should be invalidated.
>>>=20
>>> If we weren't able to fetch post-op attrs, then just set the
>>> after_change to before_change + 1. The atomic flag should already be
>>> clear in this case.
>>>=20
>>> Suggested-by: Neil Brown <neilb@suse.de>
>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>> ---
>>> fs/nfsd/nfs4proc.c | 2 +-
>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> I'm not sure this change makes any difference. The client would
>> possibly see the change value move forward then back. I'd think a
>> false "atomic" field and using the /same/ pre- and post-change would
>> be safer...?
>>=20
>> But I'm intrigued enough to apply this to nfsd-next provisionally,
>> at least for testing and further review. It will appear a little
>> later today.
>>=20
>>=20
>=20
> Thanks. I think there really are no great choices here.
>=20
> This is a rather unlikely error case that should only come into play
> when there are problems with the underlying filesystem, but only when
> fetching the post-op attrs.
>=20
> We don't have a way to just opt out of providing a post-op attribute and
> I think this is probably the least bad option of what to put in there.

No argument, it's a rock-and-hard-place thing.

There doesn't seem to be a way of testing this except
with fault injection.

Any client implementer that has an opinion about our
choice of post-change value (zero versus pre-change
versus pre-change-plus-one), please chime in.


>>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>>> index 3f6710c9c5c9..f0f318e78630 100644
>>> --- a/fs/nfsd/nfs4proc.c
>>> +++ b/fs/nfsd/nfs4proc.c
>>> @@ -411,7 +411,7 @@ set_change_info(struct nfsd4_change_info *cinfo, st=
ruct svc_fh *fhp)
>>> if (WARN_ON_ONCE(!fhp->fh_pre_saved))
>>> cinfo->before_change =3D 0;
>>> if (!fhp->fh_post_saved)
>>> - cinfo->after_change =3D 0;
>>> + cinfo->after_change =3D cinfo->before_change + 1;
>>> }
>>>=20
>>> static __be32
>>>=20
>>> ---
>>> base-commit: 97a5d0146ef443df148805a4e9c3c44111f14ab1
>>> change-id: 20230724-bz2223560-5ed6bc3a5db7
>>>=20
>>> Best regards,
>>> --=20
>>> Jeff Layton <jlayton@kernel.org>
>>>=20
>>=20
>=20
> --=20
> Jeff Layton <jlayton@kernel.org>


--
Chuck Lever


