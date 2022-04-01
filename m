Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 435E04EFA9E
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Apr 2022 21:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236540AbiDATz2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 1 Apr 2022 15:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233319AbiDATz1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 1 Apr 2022 15:55:27 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A0B6D185
        for <linux-nfs@vger.kernel.org>; Fri,  1 Apr 2022 12:53:36 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 231J4whF014843;
        Fri, 1 Apr 2022 19:53:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=wKb7rOln784whaRT+F9+BKxbK1MNzA2iXayjp1OdrYo=;
 b=W1Gf8TWHu9O9FmeqMOFXuWYXxTWZtgeXMJqml5spu/gnlA4Mia+zuJGXUOR5NWXIhxXF
 lpWKPpibRP4oHtx/x384vELHbkgQ3vsfSfdHYxMo0VN0ZDO4HfmfKAgmNHL+25dbT6BD
 V/lPvJI6wdMmhpIxSKh5fVHwxLIZSraNHA0xWxDtIz/z77xg3TAriQK8LxTqaYDaFua7
 hgNIu0pC0FinVzlq/Uv0JoI1kIQExvXBg2oNlCpyFSHHeDmMVF+Sw8PVlGsvzyGjcXYm
 koG9muuFIjTYjrD1AxWGXREatYSqTT2U1U4JdR8xSihIu0RAjOW7PPly390s9ho+waDA lg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1sm2r015-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Apr 2022 19:53:33 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 231JoV4O028017;
        Fri, 1 Apr 2022 19:53:32 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f1s99brbu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Apr 2022 19:53:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XEqs+WPyAda4pVoMXORvdt2DSF9BkELil1lGc1sVLdMor+qJ8rIn5oBxkoqtHm/3zKCqUYMKEB77P+0X9tlfXVJafhdDo3n1T5fbnt8cPQ1RHAlQcZNGpE44KZVnZ/fi2GCOTGkU4FJgmpOB1fyyErYhppWn+6PablzqqO4CaEgodP609B4wddW9EgWTOeUpslRdFYjpdZgSXDRPI2wr6XYotF30jy+EeaOWpq5bQ6t4LMlqNC0z0KaNO0pvPBrPCgu8ATV+wi6uXpvAxYXNRUsXAkVCOmpPET7PAQXt0UYak0GKstatsEQeNYGa9wUX967Jpy0v/F0jQRFGW2FKog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wKb7rOln784whaRT+F9+BKxbK1MNzA2iXayjp1OdrYo=;
 b=HzEMwIlMwgzCMDsS3mSgOE+8fs9aofMPXKirfauTwS7hM2pDWcRJB1kBbTib9D+tdQP48YnunyTO0ThNWlOV1V+U9zD+90dwPpYxjjZRaF66v2MLVYRRs16+PwkiYMg/5zYEMFOBgZInythdYNNkCr8JHPrKh2eRguymT0DrlOPYBBgzLFQRNMoU/4NlP6ZbrYADAZGdZUvdrJQ0dtrO5qI5c6p8jhKPJqa26oy8Uc7pDS9EJYQCV1X3KUUUmsxu1aNYLgASH+z7iBTtHarWjhbnqiRJr4xkuCyhm7zNUcQp4lxoHtdQiMo2JYaxVWY294MGzZEFNozfTOmZFkRmmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wKb7rOln784whaRT+F9+BKxbK1MNzA2iXayjp1OdrYo=;
 b=HFeIosw2YqnDm6bH5EYG7yI1FDBK0W8oXLzfSOGbribS5mAzbUnWWxMFG9x/df/cfmljovmGBDE5TPlgXo8QrIRhBHtfQ4MjBEPe4Kq2I7cxDbPnnQZYyS5WubzH9jNOPI3+7dG6DOZ3hYUxarK4Iy4mPERhSp7eBdpf+KjeLNg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN6PR10MB2846.namprd10.prod.outlook.com (2603:10b6:805:d0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.25; Fri, 1 Apr
 2022 19:53:30 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::f427:92a0:da5d:7d49]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::f427:92a0:da5d:7d49%6]) with mapi id 15.20.5123.026; Fri, 1 Apr 2022
 19:53:30 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
CC:     Steve Dickson <SteveD@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: exportfs recursively processes backslash escapes in exports file
Thread-Topic: exportfs recursively processes backslash escapes in exports file
Thread-Index: AQHYLOH0OVnWSPPHSECPPZn6/iZFW6zYPw4AgANrf4A=
Date:   Fri, 1 Apr 2022 19:53:30 +0000
Message-ID: <60160726-09D9-4963-B7D4-888D306B433A@oracle.com>
References: <20220228193235.2g2uvf7fphj4jdy5@tarta.nabijaczleweli.xyz>
 <20220330153958.3vmk6pi7qpxjrp5t@tarta.nabijaczleweli.xyz>
In-Reply-To: <20220330153958.3vmk6pi7qpxjrp5t@tarta.nabijaczleweli.xyz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9cefc7d7-e1de-4733-a82b-08da14194bed
x-ms-traffictypediagnostic: SN6PR10MB2846:EE_
x-microsoft-antispam-prvs: <SN6PR10MB28466DB30B9EA24F7E6DE2F893E09@SN6PR10MB2846.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WHz8glfCErzw6hCKDIUANZIqb2iszgxQpmaBLsaj/NRrBqYE3sE0wXQUSWq0naEMqKlOcnSBoE7AWAjG/2Z69vZT1nobT7gI782dRDdPqzWYCND3Mqwf86AX0ualBxd0VeA+zg/vAnMWwCuZiW9A3a0MycxMRnnfh8pHg5upoBltWxHa/OcqAJZ3YHSYyr8L9UG6bX3rECpqEOGgLH8x5bfwCncLvUX/VCW9n5kZa4QziuQbSy153R+kZkiwVUm7LnXFgkk3iEtAxcmpvxX3OnlCsDz/vvvvyeHxuto0Oz0aKmiAFwl90ui7epvY1S/kf/kL/ie8EOx1QqbsftaPQsc9tjsXV9Omfj8ilidre8xz7C8Gt8SE/G9x+fuPfhi0nCIpotMtzg9d/XZwvJ2Bq+GR64GOWTBFsTgBgvW7FgVdB7j047q0Pjkkh0Ex82VmekDaQ3Z6pdiW5xC5UFGvuYEQWmtrDbGFNAP3e6OYXmmZjUWuAFfG84xaVYOt5NCnLItEtCdVdwtNruXJjXLACRbzmtQ7yqkm4nSfPRqfUKXo1KPLo7HqDb+PmH6j9AQ1aSQt9hZ6SHUYjaB1SfO7ASptW7r5niNhnjOnlswEaVXB/0KHGIEqV16Tm4LweDrLbtkbLZ1ltTpI2FXrOZo2QxxGA9tIjBGKSCOJgqZHRoCuq2nK/44Cg28PtvgPiiV0rntuycNPlJnT3V/9cestYhH7nkuAU1ukqrNLK3hiYEqrHtSPthypW0OzY2nocTYX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(38100700002)(26005)(186003)(122000001)(38070700005)(86362001)(2616005)(66556008)(2906002)(316002)(4326008)(66476007)(66446008)(54906003)(6916009)(53546011)(5660300002)(76116006)(8936002)(36756003)(91956017)(8676002)(64756008)(71200400001)(66946007)(6512007)(508600001)(6506007)(6486002)(33656002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZHNyMWR6OHdROEUyYk85RDYzM1MvZUlWZHBrSmEycVlpYThtVHI3T1FlOHJH?=
 =?utf-8?B?WEozR0VDSFp2aFF1MVJQN2Z2bmdVOUF0YVdQNkpib1lpNlFoZnlxekhEN3ZY?=
 =?utf-8?B?d1RvYmFBQTUxU1czdXhORXdMNlBQQm1ubmVscVFmdkZ0TXdmc2IxcDNQTEFw?=
 =?utf-8?B?Uk5jV1JDYnRMZ1Q5SFdZUXdlNjFoK040S0o1eWxWWk5nYnhSL1kwejFCWTFJ?=
 =?utf-8?B?NFFnT3NNRVAyM055bGFJK2xQRVl0dTM0M3JOdURoZk80d0ZDN0NpNmE0MzRu?=
 =?utf-8?B?MlNndS80U25vRDNnNG9XVVlMb0NONlBNck1zL28yL0hxUG9FUlpRSHhCQ1F1?=
 =?utf-8?B?M3ZNOWFVNVlMQmV2SmlUZ1d6eHM3UUFab1lrMEVBUCtZK1Y3YzB5OGU0UmxI?=
 =?utf-8?B?VFU1bWIrRkdKV0c5YkM0QUlzMUZZT01iQTB3VjR2a1dEUjYvL3dmeUJIWVli?=
 =?utf-8?B?b0JQYVhZK3hWOXhzUkM5MnVmNjZacFNtQUpNMDI0WWowS00xQkZEYjc0UUcx?=
 =?utf-8?B?ZDZTNkNZalJaOXByK2QydVZNZG5PbGR6N2ZmK0NieXhUNFlQVUZHSzRhVzBE?=
 =?utf-8?B?MG9hU3ZNYXdtUS9BVDRnaEpnQTNBNHJEUitmYTB2eWVhSjk3eFdNZm9VTWFq?=
 =?utf-8?B?YmlMVFN3YjRCaGVVYUNXM29GOS90YUFOdjJNbUdMNWVJVGMyQ25IdFZnOFo0?=
 =?utf-8?B?UUkwR29oN3VCWkFlRWZNZWJ4c1g0OVBtNlhQS2tSSUpwRmNCdi8wZm9zODg4?=
 =?utf-8?B?VWd6cDZYWWlGdnVzdVlTWi9DaXAzWmVkdkZGUnJLVklnTXJtWEh6NjlSY0Fs?=
 =?utf-8?B?V3pkT3hLdXNkZXpVVjJKRTUxdVlKWTNoUGw4VVNTMjhudjNrRVBubEFPRkxY?=
 =?utf-8?B?bytFUS9DOTFBQlgyb09URW5VRzdORXJITjUrSGFQVEtDay93TGtXWFVtR0Y5?=
 =?utf-8?B?Mk9DNVFDUStQbEdOVVp2amwyaTl4YUs0akphaFBKQ25wQTIxZHZNR3R6Znh6?=
 =?utf-8?B?VWdOVHNtT2VsOHdpTG5OaXFyNGRhaXJ3U0dMN05IdGliR2pDVXI2T1FzaklB?=
 =?utf-8?B?QWJlZGhWa2k3TUErcjBOUG9JWlR5d3czdWxJdkZPQjF3eDNENkdGT2dJWmk0?=
 =?utf-8?B?dkY4VVU2SWtKUEtGbzVrUmtzWDVaR2FEQW82UUlZWFlsTGJhOGhsT1RmUW5Y?=
 =?utf-8?B?S3ZMRkMwbzQzcElRdWR4U0JLU1l5M0VaVGxUMEdGTUMxWWZjQUN6UjBVNXNw?=
 =?utf-8?B?aXd3UVJTZlErUGtYZHhldXVTVkpqYU4yZmNrM2U1QmZwaDlyaGdBSk5CaFhk?=
 =?utf-8?B?dndrNVNiS1JKOEZlREZ5YTByQWllaTZSdEg1bWV5d2xDellQRXBURjZnOU5C?=
 =?utf-8?B?SEpDWWdibXZPd3lGVHVmOXEwVTFQQ29OVGNCRmk3VWRIOEZpR1M4SmR0Wlhq?=
 =?utf-8?B?VDFHQTVxcGpTL2x3TXdyQ0RSOGFiYkNrc0hJekxuaitlaGMrUEs3OFdzWGlG?=
 =?utf-8?B?U2pHLy9hUDJOdlBqYW5kWEpuYTJ0ZVpxWHBhd0llSUNTVVdiWUhEUTJ2YzRN?=
 =?utf-8?B?Zy9qamQwcUtFSk9Oa2FqdU5Gc3luU0Q5S25zRFIvYTkzZ0JlOXQrZFNsTmxG?=
 =?utf-8?B?SGlLUnpPQWFJWktQYTBoNEp2RUlJUU5PSU5LelVuYmV4M1FXR1I1TjU1NDVT?=
 =?utf-8?B?OEhidmQ4bjIvS0xyN0NhSWdQN3prSDlFTXpWRFZzbE80T0dlQnFVMytRSXNY?=
 =?utf-8?B?RURaUVEyOWFpT3dIRkp5NUxzNEc3MUhOK0R4MGZkdldWMWJxK2NOdlp5S2VW?=
 =?utf-8?B?T3Y2YUVRM3ZvR0JVT1IxNUd2cUpKVU9EOWlSeXFFL2N5cXg5T040eGpBQ0ty?=
 =?utf-8?B?MEpxTkc4MkxScWhmOHY1YmlnT1lEOTkwTkV0Sy9vL0hjbi9DK3pHL3RvL3dp?=
 =?utf-8?B?ZUR6K3ZyMUx1aFNQZGR2andKYUZVcUdBK1FQTWtCOEVDVHZtSjEyTThQTjR2?=
 =?utf-8?B?WngvMjlZdDVjMUt0MnhaLzlUZlBkdXBOajc2cTQrd1ZMUlhWOVQ3OEQxYk55?=
 =?utf-8?B?ODNiUkk4OHRtWlN2VUJ3NERXYlpVL1l1aE5tY1B5M0ZrOWJsMElKSlJoUDgr?=
 =?utf-8?B?YWUvUHVINlY2dXk5b0Rsb2MwbHZSWXVraDBjd0ZzVU42WHgrcXNaZDJtZEIw?=
 =?utf-8?B?NEpXZ3RlUEZrTEhQaXpGTXJCVFFHVVdSQzNlUUFOdGYrSHRMSmZhT3Zob2lZ?=
 =?utf-8?B?Nnp5Qm05TlNOa0wzNjYxM2w4OUx3T2liTmlDTEtHb2tGaVFYb042b0hPenpN?=
 =?utf-8?B?cjJXTG56RkllU3hDMlM4bUlSVjZLbGdnNE5iTEhvUXhqWHBoMm9qRzZoVnNS?=
 =?utf-8?Q?KS3yaD7r4ZFojt1E=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0877A77F4E505C40BEF2EC0DB1F06AE5@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cefc7d7-e1de-4733-a82b-08da14194bed
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2022 19:53:30.6013
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wYd/vC5TBDMxAsiGSWSO4l+UH3iMsECYgvl4VfUt37qrfndOK6ItwPH97nN1f7YLVwN9MHCSHeoZ2fu9sVeZpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2846
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-01_05:2022-03-30,2022-04-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 mlxlogscore=756 spamscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204010094
X-Proofpoint-ORIG-GUID: 9OmfD2Y0Kw7BoAnnNjEHY0Hk70sWwg57
X-Proofpoint-GUID: 9OmfD2Y0Kw7BoAnnNjEHY0Hk70sWwg57
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_OTHER_BAD_TLD,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQoNCj4gT24gTWFyIDMwLCAyMDIyLCBhdCAxMTozOSBBTSwg0L3QsNCxIDxuYWJpamFjemxld2Vs
aUBuYWJpamFjemxld2VsaS54eXo+IHdyb3RlOg0KPiANCj4gRm9sbG93aW5nIHVwIHdpdGggbW9y
ZSB0ZXN0aW5nOg0KPiANCj4gR2l2ZW46DQo+ICAkIG1rZGlyICdhIFwxMzQwNTMgYicgJ2EgXDA1
MyBiJyAnYSArIGInDQo+ICAkIGVjaG8gYSA+ICdhIFwxMzQwNTMgYicvYQ0KPiAgJCBlY2hvIGIg
PiAnYSBcMDUzIGInL2INCj4gICQgZWNobyBjID4gJ2EgKyBiJy9jDQo+IChoZW5jZWZvcnRoIGR1
YmJlZCBhLCBiLCBjLCByZXNwZWN0aXZlbHkpLCBzdWNoIHRoYXQsIHRyaXZpYWxseToNCj4gICQg
bHMgLWxSICdhIFwxMzQwNTMgYicgJ2EgXDA1MyBiJyAnYSArIGInDQo+ICAnYSBcMDUzIGInOg0K
PiAgdG90YWwgNA0KPiAgLXJ3LXItLXItLSAxIG5hYmlqYWN6bGV3ZWxpIHVzZXJzIDIgTWFyIDMw
IDE3OjE3IGINCj4gDQo+ICAnYSBcMTM0MDUzIGInOg0KPiAgdG90YWwgNA0KPiAgLXJ3LXItLXIt
LSAxIG5hYmlqYWN6bGV3ZWxpIHVzZXJzIDIgTWFyIDMwIDE3OjE3IGENCj4gDQo+ICAnYSArIGIn
Og0KPiAgdG90YWwgNA0KPiAgLXJ3LXItLXItLSAxIG5hYmlqYWN6bGV3ZWxpIHVzZXJzIDIgTWFy
IDMwIDE3OjE3IGMNCj4gDQo+IEFuZCBlYWNoIGlzIGV4cG9ydGVkIGFzIHN1Y2g6DQo+ICAjIGV4
cG9ydGZzIC12byBmc2lkPTEwMCBzemFyb3RrYTonL3RtcC9hIFwxMzQwNTMgYicNCj4gICMgZXhw
b3J0ZnMgLXZvIGZzaWQ9MjAwIHN6YXJvdGthOicvdG1wL2EgXDA1MyBiJw0KPiAgIyBleHBvcnRm
cyAtdm8gZnNpZD0zMDAgc3phcm90a2E6Jy90bXAvYSArIGInDQo+ICBleHBvcnRpbmcgc3phcm90
a2EubmFiaWphY3psZXdlbGkueHl6Oi90bXAvYSBcMTM0MDUzIGINCj4gIGV4cG9ydGluZyBzemFy
b3RrYS5uYWJpamFjemxld2VsaS54eXo6L3RtcC9hIFwwNTMgYg0KPiAgZXhwb3J0aW5nIHN6YXJv
dGthLm5hYmlqYWN6bGV3ZWxpLnh5ejovdG1wL2EgKyBiDQo+IA0KPiBUaGVuOg0KPiAgSWYgb25s
eSBhIGlzIGV4cG9ydGVkLCB0aGUgZm9sbG93aW5nIHN0YXRlIGlzIGFjaGlldmVkOg0KPiAgICAj
IGV4cG9ydGZzDQo+ICAgIC90bXAvYSArIGIgICAgICBzemFyb3RrYS5uYWJpamFjemxld2VsaS54
eXoNCj4gICAgL21udC9maWxsaW5nL21hY2hpbmUvMTIwMC1TMTIxDQo+ICAgICAgICAgICAgICAg
ICAgICA8d29ybGQ+DQo+ICAgICMgZXhwb3J0ZnMgLXMNCj4gICAgL3RtcC9hXDA0MCtcMDQwYiAg
c3phcm90a2EubmFiaWphY3psZXdlbGkueHl6KHJvLHdkZWxheSxyb290X3NxdWFzaCxub19zdWJ0
cmVlX2NoZWNrLGZzaWQ9MTAwLHNlYz1zeXMscm8sc2VjdXJlLHJvb3Rfc3F1YXNoLG5vX2FsbF9z
cXVhc2gpDQo+ICAgIC9tbnQvZmlsbGluZy9tYWNoaW5lLzEyMDAtUzEyMSAgKihydyxhc3luYyx3
ZGVsYXksY3Jvc3NtbnQsbm9fcm9vdF9zcXVhc2gsbm9fc3VidHJlZV9jaGVjayxtb3VudHBvaW50
LHNlYz1zeXMscncsc2VjdXJlLG5vX3Jvb3Rfc3F1YXNoLG5vX2FsbF9zcXVhc2gpDQo+ICAgICQg
Y2F0IC92YXIvbGliL25mcy9ldGFiDQo+ICAgIC90bXAvYVwwNDBcMTM0MTM0MDUzXDA0MGIgICAg
ICAgc3phcm90a2EubmFiaWphY3psZXdlbGkueHl6KHJvLHN5bmMsd2RlbGF5LGhpZGUsbm9jcm9z
c21udCxzZWN1cmUscm9vdF9zcXVhc2gsbm9fYWxsX3NxdWFzaCxub19zdWJ0cmVlX2NoZWNrLHNl
Y3VyZV9sb2NrcyxhY2wsbm9fcG5mcyxmc2lkPTEwMCxhbm9udWlkPTY1NTM0LGFub25naWQ9NjU1
MzQsc2VjPXN5cyxybyxzZWN1cmUscm9vdF9zcXVhc2gsbm9fYWxsX3NxdWFzaCkNCj4gICAgL21u
dC9maWxsaW5nL21hY2hpbmUvMTIwMC1TMTIxICAqKHJ3LGFzeW5jLHdkZWxheSxoaWRlLGNyb3Nz
bW50LHNlY3VyZSxub19yb290X3NxdWFzaCxub19hbGxfc3F1YXNoLG5vX3N1YnRyZWVfY2hlY2ss
c2VjdXJlX2xvY2tzLGFjbCxub19wbmZzLG1vdW50cG9pbnQsYW5vbnVpZD02NTUzNCxhbm9uZ2lk
PTY1NTM0LHNlYz1zeXMscncsc2VjdXJlLG5vX3Jvb3Rfc3F1YXNoLG5vX2FsbF9zcXVhc2gpDQo+
IA0KPiAgSWYgdGhlbiBiIGlzIGFsc28gZXhwb3J0ZWQsIHRoZSBmb2xsb3dpbmcgc3RhdGUgaXMg
YWNoaWV2ZWQ6DQo+ICAgICMgZXhwb3J0ZnMNCj4gICAgL3RtcC9hICsgYiAgICAgIHN6YXJvdGth
Lm5hYmlqYWN6bGV3ZWxpLnh5eg0KPiAgICAvbW50L2ZpbGxpbmcvbWFjaGluZS8xMjAwLVMxMjEN
Cj4gICAgICAgICAgICAgICAgICAgIDx3b3JsZD4NCj4gICAgIyBleHBvcnRmcyAtcw0KPiAgICAv
dG1wL2FcMDQwK1wwNDBiICBzemFyb3RrYS5uYWJpamFjemxld2VsaS54eXoocm8sd2RlbGF5LHJv
b3Rfc3F1YXNoLG5vX3N1YnRyZWVfY2hlY2ssZnNpZD0xMDAsc2VjPXN5cyxybyxzZWN1cmUscm9v
dF9zcXVhc2gsbm9fYWxsX3NxdWFzaCkNCj4gICAgL21udC9maWxsaW5nL21hY2hpbmUvMTIwMC1T
MTIxICAqKHJ3LGFzeW5jLHdkZWxheSxjcm9zc21udCxub19yb290X3NxdWFzaCxub19zdWJ0cmVl
X2NoZWNrLG1vdW50cG9pbnQsc2VjPXN5cyxydyxzZWN1cmUsbm9fcm9vdF9zcXVhc2gsbm9fYWxs
X3NxdWFzaCkNCj4gICAgJCBjYXQgL3Zhci9saWIvbmZzL2V0YWINCj4gICAgL3RtcC9hXDA0MCtc
MDQwYiAgICAgICAgc3phcm90a2EubmFiaWphY3psZXdlbGkueHl6KHJvLHN5bmMsd2RlbGF5LGhp
ZGUsbm9jcm9zc21udCxzZWN1cmUscm9vdF9zcXVhc2gsbm9fYWxsX3NxdWFzaCxub19zdWJ0cmVl
X2NoZWNrLHNlY3VyZV9sb2NrcyxhY2wsbm9fcG5mcyxmc2lkPTEwMCxhbm9udWlkPTY1NTM0LGFu
b25naWQ9NjU1MzQsc2VjPXN5cyxybyxzZWN1cmUscm9vdF9zcXVhc2gsbm9fYWxsX3NxdWFzaCkN
Cj4gICAgL3RtcC9hXDA0MFwxMzQwNTNcMDQwYiAgc3phcm90a2EubmFiaWphY3psZXdlbGkueHl6
KHJvLHN5bmMsd2RlbGF5LGhpZGUsbm9jcm9zc21udCxzZWN1cmUscm9vdF9zcXVhc2gsbm9fYWxs
X3NxdWFzaCxub19zdWJ0cmVlX2NoZWNrLHNlY3VyZV9sb2NrcyxhY2wsbm9fcG5mcyxmc2lkPTIw
MCxhbm9udWlkPTY1NTM0LGFub25naWQ9NjU1MzQsc2VjPXN5cyxybyxzZWN1cmUscm9vdF9zcXVh
c2gsbm9fYWxsX3NxdWFzaCkNCj4gICAgL21udC9maWxsaW5nL21hY2hpbmUvMTIwMC1TMTIxICAq
KHJ3LGFzeW5jLHdkZWxheSxoaWRlLGNyb3NzbW50LHNlY3VyZSxub19yb290X3NxdWFzaCxub19h
bGxfc3F1YXNoLG5vX3N1YnRyZWVfY2hlY2ssc2VjdXJlX2xvY2tzLGFjbCxub19wbmZzLG1vdW50
cG9pbnQsYW5vbnVpZD02NTUzNCxhbm9uZ2lkPTY1NTM0LHNlYz1zeXMscncsc2VjdXJlLG5vX3Jv
b3Rfc3F1YXNoLG5vX2FsbF9zcXVhc2gpDQo+IA0KPiAgSWYgdGhlbiBjIGlzIGFsc28gZXhwb3J0
ZWQsIHRoZSBmb2xsb3dpbmcgc3RhdGUgaXMgYWNoaWV2ZWQ6DQo+ICAgICMgZXhwb3J0ZnMNCj4g
ICAgL3RtcC9hICsgYiAgICAgIHN6YXJvdGthLm5hYmlqYWN6bGV3ZWxpLnh5eg0KPiAgICAvbW50
L2ZpbGxpbmcvbWFjaGluZS8xMjAwLVMxMjENCj4gICAgICAgICAgICAgICAgICAgIDx3b3JsZD4N
Cj4gICAgIyBleHBvcnRmcyAtcw0KPiAgICAvdG1wL2FcMDQwK1wwNDBiICBzemFyb3RrYS5uYWJp
amFjemxld2VsaS54eXoocm8sd2RlbGF5LHJvb3Rfc3F1YXNoLG5vX3N1YnRyZWVfY2hlY2ssZnNp
ZD0zMDAsc2VjPXN5cyxybyxzZWN1cmUscm9vdF9zcXVhc2gsbm9fYWxsX3NxdWFzaCkNCj4gICAg
L21udC9maWxsaW5nL21hY2hpbmUvMTIwMC1TMTIxICAqKHJ3LGFzeW5jLHdkZWxheSxjcm9zc21u
dCxub19yb290X3NxdWFzaCxub19zdWJ0cmVlX2NoZWNrLG1vdW50cG9pbnQsc2VjPXN5cyxydyxz
ZWN1cmUsbm9fcm9vdF9zcXVhc2gsbm9fYWxsX3NxdWFzaCkNCj4gICAgJCBjYXQgL3Zhci9saWIv
bmZzL2V0YWINCj4gICAgL3RtcC9hXDA0MCtcMDQwYiAgICAgICAgc3phcm90a2EubmFiaWphY3ps
ZXdlbGkueHl6KHJvLHN5bmMsd2RlbGF5LGhpZGUsbm9jcm9zc21udCxzZWN1cmUscm9vdF9zcXVh
c2gsbm9fYWxsX3NxdWFzaCxub19zdWJ0cmVlX2NoZWNrLHNlY3VyZV9sb2NrcyxhY2wsbm9fcG5m
cyxmc2lkPTMwMCxhbm9udWlkPTY1NTM0LGFub25naWQ9NjU1MzQsc2VjPXN5cyxybyxzZWN1cmUs
cm9vdF9zcXVhc2gsbm9fYWxsX3NxdWFzaCkNCj4gICAgL21udC9maWxsaW5nL21hY2hpbmUvMTIw
MC1TMTIxICAqKHJ3LGFzeW5jLHdkZWxheSxoaWRlLGNyb3NzbW50LHNlY3VyZSxub19yb290X3Nx
dWFzaCxub19hbGxfc3F1YXNoLG5vX3N1YnRyZWVfY2hlY2ssc2VjdXJlX2xvY2tzLGFjbCxub19w
bmZzLG1vdW50cG9pbnQsYW5vbnVpZD02NTUzNCxhbm9uZ2lkPTY1NTM0LHNlYz1zeXMscncsc2Vj
dXJlLG5vX3Jvb3Rfc3F1YXNoLG5vX2FsbF9zcXVhc2gpDQo+IA0KPiBOb3RlIGhvdyBhIGFuZCBi
IHdlcmUgZm9sZGVkIGludG8gYyg/KSBidXQgbm90IGludG8gZWFjaCBvdGhlciwNCj4gd2hpY2gg
aXMgZXNwZWNpYWxseSBjb25jZXJuaW5nIGdpdmVuLCB0aGF0LCBpbiAvZXZlcnkvIGNhc2UsIHJl
Z2FyZGxlc3MNCj4gd2hpY2ggYXJlIGV4cG9ydGVkOg0KPiAgc3phcm90a2EkIG1rZGlyIGEgYiBj
DQo+ICBzemFyb3RrYSMgbW91bnQgLXQgbmZzIHRhcnRhOicvdG1wL2EgXDEzNDA1MyBiJyBhDQo+
ICBtb3VudC5uZnM6IG1vdW50aW5nIHRhcnRhOi90bXAvYSBcMTM0MDUzIGIgZmFpbGVkLCByZWFz
b24gZ2l2ZW4gYnkgc2VydmVyOiBObyBzdWNoIGZpbGUgb3IgZGlyZWN0b3J5DQo+ICBzemFyb3Rr
YSMgbW91bnQgLXQgbmZzIHRhcnRhOicvdG1wL2EgXDA1MyBiJyBiDQo+ICBtb3VudC5uZnM6IG1v
dW50aW5nIHRhcnRhOi90bXAvYSBcMDUzIGIgZmFpbGVkLCByZWFzb24gZ2l2ZW4gYnkgc2VydmVy
OiBObyBzdWNoIGZpbGUgb3IgZGlyZWN0b3J5DQo+ICBzemFyb3RrYSMgbW91bnQgLXQgbmZzIHRh
cnRhOicvdG1wL2EgKyBiJyBjDQo+ICBuYWJpamFjemxld2VsaUBzemFyb3RrYTovdG1wJCBsIGMN
Cj4gIHRvdGFsIDQuMEsNCj4gIC1ydy1yLS1yLS0gMSBuYWJpamFjemxld2VsaSB1c2VycyAyIE1h
ciAzMCAxNzoxNyBjDQo+IA0KPiBUaGlzIGNvdWxkIGJlIHNwdW4gYXMgYW4gImFjY2lkZW50YWwg
ZXhwb3N1cmUiIGJ1ZyBvciB3L2UsIGJ1dCB0aGlzIGlzDQo+IHByaW1hcmlseSBqdXN0IGluc2Fu
ZS4gT3IsIGlmIGl0J3Mgc29tZWhvdyBleHBlY3RlZCBhbmQgd29ya2luZyBhcw0KPiBpbnRlbmRl
ZCwgdGhlbiBpdCB3YXJyYW50cyBhIG5vdGUgaW4gdGhlIG1hbnVhbCwgYXQgbGVhc3QuDQo+IA0K
PiBCZXN0LA0KPiDQvdCw0LENCj4gDQo+IFBsZWFzZSBrZWVwIG1lIGluIENDLCBhcyBJJ20gbm90
IHN1YnNjcmliZWQuDQoNCkl0J3MgbGlrZWx5IGFuIGlzc3VlIGluIGV4cG9ydGZzIGl0c2VsZiwg
c28gQ2M6IFN0ZXZlLg0KDQpZb3UgY2FuIHNlZSB3aGF0IHRoZSBrZXJuZWwgdGhpbmtzIGlzIGl0
cyByZWFsaXR5IHdpdGg6DQoNCiMgY2F0IC9wcm9jL25ldC9ycGMvbmZzZC5leHBvcnQvY29udGVu
dA0KI3BhdGggZG9tYWluKGZsYWdzKQ0KL2V4cG9ydC90bXAJKihydyxpbnNlY3VyZSxub19yb290
X3NxdWFzaCxhc3luYyx3ZGVsYXksbm9fc3VidHJlZV9jaGVjayx1dWlkPTY2ODJiMjU4OjAyYTU0
MDYxOjgxNWNlZTE0OjI0MmRkZmMyLHNlYz0xOjM5MDAwMzozOTAwMDQ6MzkwMDA1KQ0KDQoNCi0t
DQpDaHVjayBMZXZlcg0KDQoNCg0K
