Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 221DD757F1C
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jul 2023 16:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjGRONJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 Jul 2023 10:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233266AbjGROM4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 Jul 2023 10:12:56 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36BBC1719
        for <linux-nfs@vger.kernel.org>; Tue, 18 Jul 2023 07:12:54 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36ID7o8X027498;
        Tue, 18 Jul 2023 14:12:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Y9kbbR/sh1i+htT47rQYXfNmW/C22F/seZLA4uYa5+Y=;
 b=rC8gMeYKZ9AwkaX3XSOvgDWNN/Kp2QD3orvG424csuMBmi899tP7vbOPg5FnbyNe5vNN
 fh8Ty2y7dULj5ODLkO8geGEIBb8ldAkg5TnhcSnnqRxfCkXkRCAb3mETJ5pZyZyq4ZXj
 Ks/GGrkiUWbNkEP0+/UmhDKHclst+ZlcXSGGVzh5cinFPAmuIw10XW8eKC4iccVelkU2
 Y8Kz5BRhCbQ0oHRAfGl9q+2hM1fKsCwUQ02cV+Zw+Z4BD/z6UaOp1u8nbYhYskB1m1LT
 ZN895cYVrbxcBrrNrF6tsW2ifplVyI2RUL1FUweTccGKOGFJMxMTb03Plnz5HGLqXtXW sg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run7854kq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jul 2023 14:12:49 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36IDbojA017453;
        Tue, 18 Jul 2023 14:12:48 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw54u2j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jul 2023 14:12:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m2DNJ19hC+Kq8grD7foxrt0VGedkWlJKF9ALZDub3NjNpKnF05qnI6tkHlmC1fbbEyIBx4DuDFW3C6BTDDDnR1Y5AOfiDkrjdnQRqrv91GbsYzoi8sqpSs995KH5rt4gI5eecshExIAt+DS8VkItTLG+M+r413bayjHJ/+wXJej5yv2DPCFH8FDPg1Do6m1F8QCN7VeRZnH65lyxT7weUy9Ooscp4FP8+YohtvrNScW0oxDfnaP4F/gjIIEzDn0ZT+TSkP6KLTivvEsVoQmC2Qq39xD5vQ/kaTFzrI89T92svPmcVM9Hu/JecJwbkvIf8vBBumq/UUs8IX03DOEnuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y9kbbR/sh1i+htT47rQYXfNmW/C22F/seZLA4uYa5+Y=;
 b=dTQgJxNsuV6yp/zGA4nF3qkTQtkwiS//D51+sZsEK0lGYMMVRNeDHcJKAECq1Hy3PcVTFL2nQPiFKuZVQJBJawRreyaVbSRk3rYiHt1/mDfQnVq0a3easbqrpqCQXbOSDs0yblMk7MqpU88z0HJhbd5k0g0iv0DIgihheV5R1tUeDvKPM/1xpHRHdZ4WpmSyyic7LfvrLlCbfMg9P1NJ+evZYhPoxi39eIQANHuNSxH579VXzORhx3Sp2BTiWngntal3u4V9BUvQIz/7W1uI2RS9PYat/wRR7c/ouV0JvoOtQnC7EKi3xdgwt/ELHbF+D0QjTfKfMAGqSKt3Wm7d8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y9kbbR/sh1i+htT47rQYXfNmW/C22F/seZLA4uYa5+Y=;
 b=yz3ydpaPWkIBE52BVz1Xc7je2IS+ehB6JHj4IW4oFFSQWanoDhwCkJNgBk8wzPEy/7cIIOX71xcfKtbqXkVXnD/q+V59TqwLxiRrVIncwfmt0fc1l89S7S6tgkoPBHYumn9jADdEGfxwx97fiIPfLFZW4L66dfSuBnOXQkYQXNk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB4757.namprd10.prod.outlook.com (2603:10b6:510:3f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Tue, 18 Jul
 2023 14:12:46 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6609.022; Tue, 18 Jul 2023
 14:12:46 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@kernel.org>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfsd: Remove incorrect check in nfsd4_validate_stateid
Thread-Topic: [PATCH] nfsd: Remove incorrect check in nfsd4_validate_stateid
Thread-Index: Adm5gez8AMDXxg8uk0eRIFrdiLXESg==
Date:   Tue, 18 Jul 2023 14:12:46 +0000
Message-ID: <0F52C77C-C1AA-48E1-B30A-CD15342EEAFF@oracle.com>
References: <20230718123837.124780-1-trondmy@kernel.org>
 <6dc89e4859a6851773bc2931d919e1cb204ae690.camel@kernel.org>
 <106daf5e0242b67bdb04e2e8e4ae7e114a4b47ab.camel@kernel.org>
In-Reply-To: <106daf5e0242b67bdb04e2e8e4ae7e114a4b47ab.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH0PR10MB4757:EE_
x-ms-office365-filtering-correlation-id: 9bb3a678-ba8a-4047-04a5-08db87990f7d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: epopijarW51jVXmW0Ju0zWHB0gQlJ/Khuvqe96dXYJNI0NiQ/ZKSHmCmdsaEes9DnQf0EQTla44Zlqsn4Meylf46FJzisLtEvW0Ftw0Ba3rSK212HcUfWpaK5qrkCLYo6p/7D3nNX4M2wohMVWdFjfNo4UQS1+hhpo8IJbR+1qVwi/s7pzmZ4lBu+6+1HTRoDz9W+rPM8JPXkChITbMFDfmeUt0sthy/maSgxtaOD8bmeOz0EjMWEVCAR9ri4Rz3pyWLwYTPYViW+wrN/ZHdrRsCzMFagrYWIqaW3bJLcWY9MTF9Dn+gtZuXfWgkMg+2JAFHrUwS7VpWjMXVCFDBiCKc+im0elPR8TvL07pQiUVyaZiYxeFx+277f4QmxAs8fCoK3FJJhvPifumyxo9hit4zljhS0Dgk+JUQVj2XGv4zO1xNON6S3/AGN8MHLRn0McKrWbM5krXw2SRR48W4kt4FPDQqSD/EG8bi7I5jy1bzf+czAsXjEMAIWPiv157tZTCJBTPSM3STG7ce7LZQASb2XFfEfBlNqZzIWjZuPMlA2WMpPz5ewTGFa2BiCaS+mxpF/5efIYlL9slFwxtfU0W9364OSdHQUBEZeRm88Qt6b8Omd03ZGmnnCk0fcCSg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(366004)(136003)(376002)(39860400002)(451199021)(33656002)(6506007)(71200400001)(83380400001)(38100700002)(186003)(26005)(478600001)(38070700005)(53546011)(6486002)(54906003)(66476007)(41300700001)(8676002)(66446008)(2906002)(8936002)(66556008)(6916009)(66946007)(966005)(316002)(4326008)(5660300002)(36756003)(6512007)(2616005)(64756008)(91956017)(86362001)(76116006)(122000001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6k7tGEyZcRSg19IAJgItwftlHTJNZ9eKDmje5R2HsNRAj2JWOIKIF/x+FuKZ?=
 =?us-ascii?Q?vpQwVSzkP2iCaBWlT76RixIxMrN9fIr8YZVk9k0H/pcNbuSo8+flejeGL3s5?=
 =?us-ascii?Q?Zn/H9C+BTyLKVx2LEWiEpBgTxh56BdIQ4QKOb2ayqIvYYPi1I3jyf/UD0eKJ?=
 =?us-ascii?Q?HaoSq+uMT2vEDXZL8w6W92gZu3cgLBMKjaXczONyfu5qgzemYMyaS759C1Xu?=
 =?us-ascii?Q?ZpxMaV2eoEos2lAUpX9Z4Rp8uRczMMN4zA4s0KCTpZJNC3dRWEzPdZRrdRhQ?=
 =?us-ascii?Q?RVrvk4dgLcoeahue3ITxamfE5BmLfu95iOK5wid4XSJ3kk8W3MVA5Zt8E0iH?=
 =?us-ascii?Q?BIqIzL2UOZzG+UZMXXTtP+tE/tHwfQKQyrU85pASS04OiswOZ2h7EtKFHiVD?=
 =?us-ascii?Q?r1nyRbYVj2SUz32ePtC/LVIL0ccCpz0gCTBDUTqQXHB780X9kXMJnxwbAUra?=
 =?us-ascii?Q?RdFgbaxVkKjvzsRwK4l6JWeJvBEg7bMFwozrXrD6mi9y0Hdwc8NOrRXHp4nT?=
 =?us-ascii?Q?EqDFEmbxNDa+8WB7UYsNyW+l18iDsPvlUw/tsEOpbaUDGMlrd30sPLEkgFvM?=
 =?us-ascii?Q?hhJZYZtl/mGQxwcJA+MN/ICY0FA/hqA7H8QlYwO5QhvlT6+gZc36PvdbSFpl?=
 =?us-ascii?Q?Jkhyd4E3FNh2caFg2vlWYFOqYVzGQLi6OEbSzFnUs8hlphJbNMpT343L1iNE?=
 =?us-ascii?Q?/P8jvtCH+aVvD+n4fFnzdrfeHWRrlwg1mQ1rSx7lc7/2Go6gES7V2y1ZI2lT?=
 =?us-ascii?Q?2D91w+z/st1f+BpxeUaHUdDJDsXgk5seAFxRORLGRZbZKLvJZnAh62JqZHWF?=
 =?us-ascii?Q?Y+9sxq7lJ8kuW231BrhbqVymd//d6jM4ws4MilytNR3tJwwkH+RPORugayK9?=
 =?us-ascii?Q?XwtxKwHff47GX5qwEmG2uArVtUzxmOcBiZnZrzxhiPjXSQhgtxkiUo/ExM9+?=
 =?us-ascii?Q?ajre7CPedKP6m5XRz+i9TErGgrfjjtTt+NIvOjaBHEVcXQBnwMdIfFGznZgJ?=
 =?us-ascii?Q?m0aUStAszFpyVoJw4dnzVD8+XapLnwdlIfLb5zsAvo4U5BxaCMjQMAttMIME?=
 =?us-ascii?Q?D1AGdKHadKXTx6ndcUIRea0e5Z7xpNNFFWZL3Vc/+jVdO8BB5d16yQzIcQWO?=
 =?us-ascii?Q?3a9jS3rMYGJMya9q9Aoeyq4iOJ7dp1AGJmnLebnLjdvDRJAUaWeY0NvBWyOV?=
 =?us-ascii?Q?0WCQ60vWFLQozzk6bvjUeg+KH8axsmjYrtGctPAL9hM5YId5S/pibcyRdR5N?=
 =?us-ascii?Q?py9dRBg+hzv1mE9S7ZZZpk0kfk8DgzK//odJJQf8NPaNZs1y18f7wzKYYRH7?=
 =?us-ascii?Q?0TzbE9oC7imFfZbQzW/LpqRnFiqXhv/w1/9skx2XFu8c7hLzUiGGs7Qpg2li?=
 =?us-ascii?Q?Yni/UxLsPaavK6GfeBbUhGeMiaHojuvDYM5Mi4kE1nHZYgnIMRkff3FTybwL?=
 =?us-ascii?Q?kSsPB6JrBdy4RIWFhkSzz+j+kir/SmDzZU0fCfc3B4eDgbBv+eho1/oHzz8/?=
 =?us-ascii?Q?4x3aMJJavw7HZJyyBpkdjPukcYtstlBVjtbGE0Hj8k/jFK9tl2hN1RjkUivj?=
 =?us-ascii?Q?XN2Ng9FazoQxXH7Sk2HITGjN9+JM2KMd7C1t2ei0ov0rHE1CYlGF5gFHOjSs?=
 =?us-ascii?Q?pA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0974AEA21BBA8E4CAF18D7A150E61573@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 14dHOLsuZ5h4HfKDCW+H/yhNnpnaq4s5DXVVLbRMWfffzfBVAiX4sjp9ObLRnxyLqDec2BTUI2dTm6ux540mYGz6TyD7tHhpr4GHodk9FNMFYgVLkoKVdDD302sM8l6eU2doP307Dhq/cV8Au8iIrkqwtcQ8J9gWoSsw6f9UmhJLIDb35OgSWYUpUFXDgPS7ZutklchznurUwYq3oXKB8wVFJ0xPf9T72QpCu2SKO/yzcIYG0XgbofJmkxvbQ/2wDfVgezTbcrFBOMpB6rN2nuLTwftZ/A258MkayhNpiFT0ht4Q3/Uv6Madiakt6ULQ8z/IAgk4IIg4xnDUmKYPbVmJfV3p8u/5qLxBcue/qPnuym+C2Qe8xYkBN0pEkdk7lMFS/6q9iie5A8ZlfLl9+y7rxnPM/AxZuH+oJzXUOCEfdzb4USiRrked0obzeXJTDwfKZMVA03fF9qqSCOE4Gl4y5WfFtW05cTNczXtF7I9AQL4aaOKc62UnIcHMrXlam3ZFMNOC+7qZKook3go4IO10YXzAdJ9al7yDtr+ZTx26wy0EljQszczTrWl1ACRa8kigWZkiRrxGsza77DphxEST1/GHJWN+jW5JWg5XJYtkAEdG4LCYLg+m1uZlypo4OdKsjZF19TLESDarMxUQeUzUwXPigfEyNwgpYkhNxeLmpSTHtZ/C3cPo+fRglRDpRHoyLRwqXk/tIUOBkIUtOOnULa6ir+z5nDE63QiCk9hF5y+18NKQBab74GTO+JnnJ16UBcaprmffg5dpnBh/OMD4O6LiAaojlUaMZVqEhH0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bb3a678-ba8a-4047-04a5-08db87990f7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2023 14:12:46.2505
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VtEBvRG+1glcXiwQ1RMG3RW/N+rIudnseNTAsILviszz3qtDSVppgtLRRO5uC5/lixA5cSN1lRTC02spTXuO9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4757
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-18_10,2023-07-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 mlxscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307180130
X-Proofpoint-ORIG-GUID: oMtexnF-QC8abeno0ZDI3tmCmBmPw3Mv
X-Proofpoint-GUID: oMtexnF-QC8abeno0ZDI3tmCmBmPw3Mv
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 18, 2023, at 9:51 AM, Trond Myklebust <trondmy@kernel.org> wrote:
>=20
> On Tue, 2023-07-18 at 09:35 -0400, Jeff Layton wrote:
>> On Tue, 2023-07-18 at 08:38 -0400, trondmy@kernel.org wrote:
>>> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>>>=20
>>> If the client is calling TEST_STATEID, then it is because some
>>> event
>>> occurred that requires it to check all the stateids for validity
>>> and
>>> call FREE_STATEID on the ones that have been revoked. In this case,
>>> either the stateid exists in the list of stateids associated with
>>> that
>>> nfs4_client, in which case it should be tested, or it does not.
>>> There
>>> are no additional conditions to be considered.
>>>=20
>>> Reported-by: Frank Ch. Eigler <fche@redhat.com>
>>> Fixes: 663e36f07666 ("nfsd4: kill warnings on testing stateids with
>>> mismatched clientids")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
>>> ---
>>>  fs/nfsd/nfs4state.c | 2 --
>>>  1 file changed, 2 deletions(-)
>>>=20
>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>> index 6e61fa3acaf1..3aefbad4cc09 100644
>>> --- a/fs/nfsd/nfs4state.c
>>> +++ b/fs/nfsd/nfs4state.c
>>> @@ -6341,8 +6341,6 @@ static __be32 nfsd4_validate_stateid(struct
>>> nfs4_client *cl, stateid_t *stateid)
>>>         if (ZERO_STATEID(stateid) || ONE_STATEID(stateid) ||
>>>                 CLOSE_STATEID(stateid))
>>>                 return status;
>>> -       if (!same_clid(&stateid->si_opaque.so_clid, &cl-
>>>> cl_clientid))
>>> -               return status;
>>>         spin_lock(&cl->cl_lock);
>>>         s =3D find_stateid_locked(cl, stateid);
>>>         if (!s)
>>=20
>> IDGI. Is this fixing an actual bug? Granted this code does seem
>> unnecessary, but removing it doesn't seem like it will cause any
>> user-visible change in behavior. Am I missing something?
>=20
> It was clearly triggering in
> https://bugzilla.redhat.com/show_bug.cgi?id=3D2176575
>=20
> Furthermore, if you look at commit 663e36f07666, you'll see that all it
> does is remove the log message because "it is expected". For some
> unknown reason, it did not register that "then the check is incorrect".

I don't think 663e36f altered this logic: it "returned status"
when it emitted the warning, and it "returned status" after
the warning was removed.


> So yes, this is fixing a real bug.

If there is a bug, wouldn't it have been introduced when the
"!same_clid()" check was added?

Fixes: 7df302f75ee2 ("NFSD: TEST_STATEID should not return NFS4ERR_STALE_ST=
ATEID")


--
Chuck Lever


