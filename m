Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41ABE6F5374
	for <lists+linux-nfs@lfdr.de>; Wed,  3 May 2023 10:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbjECIkA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 3 May 2023 04:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjECIj1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 3 May 2023 04:39:27 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49414EF3;
        Wed,  3 May 2023 01:39:03 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3438ZBSl010248;
        Wed, 3 May 2023 08:38:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=PXe3xRU3KqIctzZQw4v2xVMPtdrZvzr5jcNPA/UKSrI=;
 b=C3C+Uvap/c3BVnaPLNKQD+lsaHqOMNWNRJl3NRBVUwJ73FM54Jx5QPNdOyE4tyV0iEKr
 Dmmk1KJE9Pj1Hk94LT51cR7Oeumgrd0Pk8fe3RYX27Bdn31NcmJeQVyx6v0n9tUuiq8T
 MJyRRC9YOb4uBPVmMct+OaaDyVFITROd+ahzgDXlWKiqkoyEFRI9DWm15YNfkHnFCM22
 SnWCCJtxSfXq36Q7nsnpzuJ1JoIiDbmz411nZTDc/o35m+uNbldnwjiCbR+WRRyEi9E5
 E3tva6p61WzoTBjxa4VQCwFFL1db52CLtHlu6GiYBXQqmLfWt0FxZCH88E7vF7+P4dxc /A== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qbkw48r1h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 May 2023 08:38:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hK9aXORY0L56bLt5WsuGLUmECm21DMiVcmU0vqCoxoWPvedjigNfYGEHcSnnqJqApYmSq/O0x+7S3b9l9Zr7hiDnrREcuyfZfQTMZ2N5YnKUGFqksoX+bdhvTeVfWtTs9F/gnEMjSAZm2JHDIUUJsbmOxtnMKGZG8qbL8DbItLDd3crjTm4LmvitQcWMTkbAo2Az54WtejDZPpQKBzfcoZ9h2jKPSym1F/kGQw69avtB88WiHmn2gTr/dBSYD7k+6ax1IFkvtKmxWBOMR9x0HQj+kwUXy5d9QC4Zwse3Y8c8E58gA+HhoeQyL49ZPaX7kRlYIdFN+/g0Tp5Nbk7/4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PXe3xRU3KqIctzZQw4v2xVMPtdrZvzr5jcNPA/UKSrI=;
 b=nIgMSTRr8A6PAwSXA24SlSgNfHsmgrm5sgYoLiAsXbqxuQmpEbpmWCgYwtIeNr0R17HDkUlPUPEZElNbkELSHb30auRVFXdXJ7WKVxRkj3ME8xxxiKx+kO5fDF+YAlXtPEbg2a4Ef/61PAGJcmHj4EXqrFiQpmEMc7ctnefy/7vD+hVx3cN1NOdAzmrjnV5rZjpAQpKHWXRU5d6x5kslbpWIcHSx6GN94aMFCghP4eYTsfi5quGKKy0EQW0G8eT79MgLeWhEc7lqj6m/01+7r8/Gr9iCpl1Cn7aK9wuI0I0J4ROFW61n9Vnkt4qO55b8U12K2p+We2EMqy0C9+tPmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from SA0PR15MB3919.namprd15.prod.outlook.com (2603:10b6:806:91::20)
 by MW4PR15MB5311.namprd15.prod.outlook.com (2603:10b6:303:18d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Wed, 3 May
 2023 08:35:11 +0000
Received: from SA0PR15MB3919.namprd15.prod.outlook.com
 ([fe80::5ced:e1f2:71bf:a4f0]) by SA0PR15MB3919.namprd15.prod.outlook.com
 ([fe80::5ced:e1f2:71bf:a4f0%7]) with mapi id 15.20.6363.022; Wed, 3 May 2023
 08:35:11 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Chuck Lever III <chuck.lever@oracle.com>
CC:     Chuck Lever <cel@kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: RE: Re: [PATCH RFC] RDMA/core: Store zero GIDs in some cases
Thread-Topic: Re: [PATCH RFC] RDMA/core: Store zero GIDs in some cases
Thread-Index: AQHZfZosSKgYT1RRekWDDNuk2JlyrQ==
Date:   Wed, 3 May 2023 08:35:11 +0000
Message-ID: <SA0PR15MB39197F3DA72C426FE6876408996C9@SA0PR15MB3919.namprd15.prod.outlook.com>
References: <168261567323.5727.12145565111706096503.stgit@oracle-102.nfsv4bat.org>
 <ZEvMo4qkj9NSLXTA@ziepe.ca> <34E28C03-5D1A-4DAA-9B5B-D453F8C256BD@oracle.com>
 <ZEvOec75yMrin/hB@ziepe.ca> <36CE272E-15F4-40B3-83E8-98BCFE55CA20@oracle.com>
 <ZEvSQzOjhwEYi6m0@ziepe.ca>
In-Reply-To: <ZEvSQzOjhwEYi6m0@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR15MB3919:EE_|MW4PR15MB5311:EE_
x-ms-office365-filtering-correlation-id: ab00b65d-4b2d-4f8f-01d6-08db4bb14f36
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CkfNDcDuGdIaGAQ/UfFvNUhPcI5hIFVm0QWIiOclLIx/hgxNHHEI0VFKTRJWrXGWjf9jDCn2I91nG+9KCpDJn+2a8AVT7wtybWHysQS/BAvVjetx9H2JQGTmkV6SERKflv8k8lw3EOBqmsYGHcjuiwIbDHfdOzjr7crDuvOVagLrlaUhexd5urhKZRbAsg2xQc7SN8SY+oWp7E5h6hcjuNR79kWnYwZOYliloGRl9ZmUf//Djmb2OE3kYXSpaVl6gS3PXW7LkaiUxGw6gDMW/gkJ5mPne74ZT5LABLmYpLxXx94hG2ezO/EwtlmALzI78ZB+DnuOLbvBFHxIBxp5c9OiWt58rPuxZBNljO7SDnsVVJEfBP9zFLMjhsEkMueV9b8xPQewEEYym/2Rs4Eja50yMZruBCN3FsMh8bf6vdFy/hoRAAx45SHlwR6VgZIKcNt7n0aIB/Cp+M6x9FmNPhGuRLC3J+rkQUhAd7D+IvOocXy48MZZZj+OA5SVp2a//JCVWxW9kO7LcT6xjOdZj7UT4gTaWdY2ry/3Ck05xyqlBu5F3Z8J+AqLOYLSP4rH5QEGa7CfUTCOhzWxYOsqmyP70Dyu24SbtnaJao+/Lcx49d3vzeM3Wpnt2gMHWqCI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR15MB3919.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(396003)(366004)(376002)(136003)(451199021)(6506007)(186003)(122000001)(9686003)(38100700002)(53546011)(83380400001)(38070700005)(8936002)(41300700001)(52536014)(5660300002)(8676002)(33656002)(478600001)(110136005)(55016003)(54906003)(2906002)(7696005)(316002)(71200400001)(66946007)(4326008)(86362001)(66556008)(66476007)(66446008)(64756008)(76116006)(66899021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eVgxYjlXTGpuS2F0TEZWaGI5OHg2eUhrV1Y1TytnR096VHBNcjdJQnUvVnhW?=
 =?utf-8?B?aGd3Qmo2TWJqOFFzeW9uZm9DOTZWd2MyeTE5Z1lXOGdPOVVPUkdTSHdONFkr?=
 =?utf-8?B?NDhCMUxUQWJ0UEhkSm9laWhBUVJieUhCOXp2S0dWOXZxOUc2L0pGNzVNOVpv?=
 =?utf-8?B?WVpMdUFTTm80eThkNDFJQWEyRGU4eUdmYUc4TG9Gd1FJWE1IUEZUQmpKcUht?=
 =?utf-8?B?SDRrQ1pudFNkMjZzcnpnd1ZkL0R3RTBNUGtMQW5ndzZhQTVrUE85S0lkdmpG?=
 =?utf-8?B?MGZGMkc1VnFMSjNuWXc1UzZSaTJldnRzZk1tclpCU2UwOXUxYmdRU2xPaEF1?=
 =?utf-8?B?RzIzL1c3eW0wSzdDRWpJanh5Y2svMGorWlZDUlhkTHErM25EMytURS9vVnBW?=
 =?utf-8?B?dmo2QUVtcVcxZmV0ZzFnbzVoWGcvek54MHZpbzVFQVpqS2p6dDJrbW5lRHly?=
 =?utf-8?B?ZTRCSExzWXo2ZlhSRnRtV3lzazNER1k0WEE4bzF4S3FZNXdxQVFVdDRyN3J3?=
 =?utf-8?B?VWoxWXNEZDNFdktZR0VsV3JjdmtZWjEwZUtNZE43dDkyQUZzK0NuUDdsRjNF?=
 =?utf-8?B?aXdobzlPTnhQNEpxWmhTTUQxa2Y1NVFML0svMnRFaUFBMmVwa05oVDNEVGEv?=
 =?utf-8?B?NU9DZHJQN0xxR2xMb0tZbFFZRGlDM2prbGJxS0gxTGFlWUtPcWdSSWJNZS85?=
 =?utf-8?B?dGhEN0dKMmdvSlF6RnBSTmJqaHo4blNsNnJzdlg5VDZDckh5L1YyMUVaWnRW?=
 =?utf-8?B?bEp4bXdWMmNKL2c3Y0Uzbi83bXpRbk1UZmR4WXFoV0FJQ3laQVl4Q3Ric2t2?=
 =?utf-8?B?ZVhEanhBdk9CVDR3VFRSWmN1SzN3YTl6Q2lYbmQ1My9FSmVldGtpRGsxZXhx?=
 =?utf-8?B?RUNxcnFGMlQrMXphVlJyNVRheU5ZVmN0VHFhOWY0VU9CaEM1ZHUxRDZuWDg2?=
 =?utf-8?B?MFloUFhSb2xrL3ZpQ3ZUdXllaEV6bWFNR1Qzb0tjYWxsYzJyZ2ZsUzUxNEZG?=
 =?utf-8?B?RkZRYUtYNmcrekRGNVFGK3BMK29TU1dudHVxek9ZK3FNWkZkV0NTSDZUSTdx?=
 =?utf-8?B?b3hpSmo1S25xamFId1ZmbWRUNWtrTnh3M283eHVVUUFJMmhzdVFxVlluTGMw?=
 =?utf-8?B?S1ZJd0UveTRsQ3RrdUVhcyttOTZUdk1TVlBTaGFxVUxsQ1E0bVRrMFVFMDdH?=
 =?utf-8?B?VmRtZ05rYnI0THl1UHAyU1B5VGdMRUtUWXlYbzZvaXhPNHBKR1VmZ0ZNNmY5?=
 =?utf-8?B?elJlVkVWSGVnL1ZXL09UYkZ2dVJaNXBUd1ZObSt0aDRMek9mVy9zMFlTakVm?=
 =?utf-8?B?OXRuOGw3ZjNBN1lNK3VmMlU0cjZzYXd0OWFlK0dONko2M3M2K2d6Y1hsMlVS?=
 =?utf-8?B?TnhlMW4wRDhZaUI1Q2JZZ2xiVFcxaDFtNGxNRTRRNVFLYWNmZm5xWjlIMWkv?=
 =?utf-8?B?b2l2eTAzSjJWZ0ZvVFpWdDVpV2w4OE5GTXI2YnJsb0VPRjBNZXZaV0NpVEt5?=
 =?utf-8?B?dy9zSFo3dzZESVpHbmpxQjhhd0JUdTNKUURuUmFsQmg2S21SWnVKRDM5NnFN?=
 =?utf-8?B?TmQwN0hLN29VR0FNamxwVmlsU3lKWTZRaXpRL2ZMTWJWazJQbFBoTEloQk5N?=
 =?utf-8?B?eFFQMnUwRUNyN1A2MnE3K3NBajFzNlNTMU02WE1GTTdQMmhkZVFsbWV1Ukw3?=
 =?utf-8?B?QVd5VjNCQWloT0cyazdJbUhnZUdURWtqTXp3bkpPdWhuZlh3T1EvT2hOQXpp?=
 =?utf-8?B?S1RsRWYzTURPN0VIVVd6YVQ5TWNyWVFpc0ZrNFQyVHFtUUJxQkgrN3p4UEVi?=
 =?utf-8?B?UlJVdkp0VVdRaDRUODFwNFFhZUtla2xtUTYydzh3U0pBOEY2R01XZ3Y1QXVT?=
 =?utf-8?B?Q21rSU9jRFRqc1N1VmxQVDgwOENaV1BiVWo3ZVNCSVZkV0k2dXJ1ZVpxVm5p?=
 =?utf-8?B?dDRpNkxZSmJybm5RRGxjem9GTGYrR3Y0OFZZUlA4ZkFxWWpxNi9qU0xYZkJa?=
 =?utf-8?B?dFBndkhBTHNQUjZYdFNHRVRvSWMxMGwzSVlVb09HYk5hM0ZwNjBhSUlJTUFI?=
 =?utf-8?B?TTlGZ2RKS01JZ2plVVgvMzF1anUxVnM1NHBIelEzL29qb1laMkl5WFZ2YVVO?=
 =?utf-8?B?ME5mK3E1czJsbGpLU1NYcGlWYjJDMTNvT25McFNUeU1JQnJkQnpxbnBqaUgy?=
 =?utf-8?Q?tDoGGLZkVqUbQoMlP3Na35NPT5voU759RdaBlYsWiAW9?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR15MB3919.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab00b65d-4b2d-4f8f-01d6-08db4bb14f36
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2023 08:35:11.3224
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9jXKRyxuLHP8yEnATjHuPlxRxel/6LlCUCmZGtL1egxXonwBXaGWor/CRQmTWw49zYtFCmAH0ETbzEsiDsO0dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB5311
X-Proofpoint-ORIG-GUID: -Jy1oMJnk_eHI_-Xg4bH34mIasiKI5-R
X-Proofpoint-GUID: -Jy1oMJnk_eHI_-Xg4bH34mIasiKI5-R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-03_04,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 impostorscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305030070
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFzb24gR3VudGhvcnBl
IDxqZ2dAemllcGUuY2E+DQo+IFNlbnQ6IEZyaWRheSwgMjggQXByaWwgMjAyMyAxNjowNA0KPiBU
bzogQ2h1Y2sgTGV2ZXIgSUlJIDxjaHVjay5sZXZlckBvcmFjbGUuY29tPg0KPiBDYzogQ2h1Y2sg
TGV2ZXIgPGNlbEBrZXJuZWwub3JnPjsgQmVybmFyZCBNZXR6bGVyIDxCTVRAenVyaWNoLmlibS5j
b20+Ow0KPiBsaW51eC1yZG1hIDxsaW51eC1yZG1hQHZnZXIua2VybmVsLm9yZz47IExpbnV4IE5G
UyBNYWlsaW5nIExpc3QgPGxpbnV4LQ0KPiBuZnNAdmdlci5rZXJuZWwub3JnPg0KPiBTdWJqZWN0
OiBbRVhURVJOQUxdIFJlOiBbUEFUQ0ggUkZDXSBSRE1BL2NvcmU6IFN0b3JlIHplcm8gR0lEcyBp
biBzb21lDQo+IGNhc2VzDQo+IA0KPiBPbiBGcmksIEFwciAyOCwgMjAyMyBhdCAwMTo1ODo1M1BN
ICswMDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6DQo+ID4NCj4gPg0KPiA+ID4gT24gQXByIDI4
LCAyMDIzLCBhdCA5OjQ3IEFNLCBKYXNvbiBHdW50aG9ycGUgPGpnZ0B6aWVwZS5jYT4gd3JvdGU6
DQo+ID4gPg0KPiA+ID4gT24gRnJpLCBBcHIgMjgsIDIwMjMgYXQgMDE6NDI6MjRQTSArMDAwMCwg
Q2h1Y2sgTGV2ZXIgSUlJIHdyb3RlOg0KPiA+ID4+DQo+ID4gPj4NCj4gPiA+Pj4gT24gQXByIDI4
LCAyMDIzLCBhdCA5OjM5IEFNLCBKYXNvbiBHdW50aG9ycGUgPGpnZ0B6aWVwZS5jYT4gd3JvdGU6
DQo+ID4gPj4+DQo+ID4gPj4+IE9uIFRodSwgQXByIDI3LCAyMDIzIGF0IDAxOjE0OjQzUE0gLTA0
MDAsIENodWNrIExldmVyIHdyb3RlOg0KPiA+ID4+Pj4gRnJvbTogQmVybmFyZCBNZXR6bGVyIDxi
bXRAenVyaWNoLmlibS5jb20+DQo+ID4gPj4+Pg0KPiA+ID4+Pj4gVHVubmVsIGRldmljZXMgaGF2
ZSB6ZXJvIEdJRHMsIHNvIHNraXAgdGhlIHplcm8gR0lEIGNoZWNrIHdoZW4NCj4gPiA+Pj4+IHNl
dHRpbmcgdXAgc29mdCBpV0FSUCBvdmVyIGEgdHVubmVsIGRldmljZS4NCj4gPiA+Pj4NCj4gPiA+
Pj4gSHVoPyBXaHk/IEhvdyBkb2VzIHRoYXQgbWFrZSBhbnkgc2Vuc2U/DQo+ID4gPj4NCj4gPiA+
PiBSZWFkIGl0IGFzIGEgY3J5IGZvciBoZWxwLg0KPiA+ID4+DQo+ID4gPj4gVGhlIHNjZW5hcmlv
IGlzIGF0dGVtcHRpbmcgdG8gc2V0IHVwIGEgc29mdCBpV0FSUCBkZXZpY2UNCj4gPiA+PiB3aXRo
IGEgc2xhdmUgdGhhdCBpcyBhIHR1bm5lbCBkZXZpY2UuIFRoZSBzZXQgdXAgc2VlbXMgdG8NCj4g
PiA+PiB3b3JrLCBidXQgd2hlbiBjb25uZWN0aW5nLCB0aGUgVUxQIGdldHMgYW4gQUREUl9FUlJP
Ug0KPiA+ID4+IGJlY2F1c2UgdGhlIHNldHVwIGRpZCBub3QgYWRkIGFuIGVudHJ5IHRvIHRoZSBH
SUQgdGFibGUuDQo+ID4gPg0KPiA+ID4gRG9uJ3QgYXNzaWduIGEgMCBJUCB0byB0aGUgdHVubmVs
Pw0KPiA+DQo+ID4gVGhhdCdzIGEgbGl0dGxlIGNyeXB0aWMuLi4gY2FuIHlvdSBleHBhbmQ/DQo+
ID4NCj4gPiBSaWdodCBub3cgSSBoYXZlIGEgVGFpbHNjYWxlIFZQTiBkZXZpY2Ugd2l0aCBhc3Np
Z25lZCBJUA0KPiA+IGFkZHJlc3NlczoNCj4gPg0KPiA+IDM6IHRhaWxzY2FsZTA6IDxQT0lOVE9Q
T0lOVCxNVUxUSUNBU1QsTk9BUlAsVVAsTE9XRVJfVVA+IG10dSAxMjgwDQo+IHFkaXNjIGZxX2Nv
ZGVsIHN0YXRlIFVOS05PV04gZ3JvdXAgZGVmYXVsdCBxbGVuIDUwMA0KPiA+ICAgICBsaW5rL25v
bmUgICAgICBpbmV0IDEwMC42NC4wLjE2LzMyIHNjb3BlIGdsb2JhbCB0YWlsc2NhbGUwDQo+ID4g
ICAgICAgIHZhbGlkX2xmdCBmb3JldmVyIHByZWZlcnJlZF9sZnQgZm9yZXZlcg0KPiA+ICAgICBp
bmV0NiBmZDdhOjExNWM6YTFlMDo6MTAvMTI4IHNjb3BlIGdsb2JhbCAgICAgICAgIHZhbGlkX2xm
dA0KPiBmb3JldmVyIHByZWZlcnJlZF9sZnQgZm9yZXZlcg0KPiA+ICAgICBpbmV0NiBmZTgwOjo3
MjVjOjFiNmQ6NjBlZDpmY2U0LzY0IHNjb3BlIGxpbmsgc3RhYmxlLXByaXZhY3kNCj4gdmFsaWRf
bGZ0IGZvcmV2ZXIgcHJlZmVycmVkX2xmdCBmb3JldmVyDQo+ID4NCj4gPiBBbmQgYWZ0ZXIgdGhh
dCBpL2YgaXMgVVAsIEkndmUgZG9uZSB0aGlzOg0KPiANCj4gVGhhdCBzZWVtcyBPSy4uDQo+IA0K
PiA+ICAkIHN1ZG8gcmRtYSBsaW5rIGFkZCBzaXcwIHR5cGUgc2l3IG5ldGRldiB0YWlsc2NhbGUw
DQo+ID4NCj4gPiBXaXRoIHRoZSBwYXRjaCBJIHNlbnQsIEkgY2FuIGRvIE5GUy9SRE1BIHZpYSBz
b2Z0IGlXQVJQIHRocm91Z2gNCj4gPiB0aGUgdHVubmVsLiBJJ20gbm90IGF0IGFsbCBjbGFpbWlu
ZyB0aGF0J3MgYSBnb29kIGZpeCwgYnV0IG9ubHkNCj4gPiB0aGF0IHRoaXMgc2NlbmFyaW8gaXMg
c3VwcG9zZWQgdG8gd29yaywgYnV0IGN1cnJlbnRseSBkb2Vzbid0Lg0KPiANCj4gVGhlbiB0aGVy
ZSBpcyBzb21ldGhpbmcgd3JvbmcgaW4gU0lXLCBpdCBzaG91bGQgbm90IGJlIHJlcG9ydGluZyAw
DQo+IEdJRHMgdG8gdGhlIGNvcmUgY29kZSBmb3IgdGhhdCBraW5kIG9mIGRldmljZS4NCj4gDQo+
IEkgZG9uJ3QgcmVtZW1iZXIgd2hhdCBpd2FycCB1c2VzIGZvciBpdCdzIGd1aWQgZm9ybWF0IC4u
IE1heWJlIGl0IHdhcw0KPiBtYWMgYWRyZXNzIG9yIHNvbWV0aGluZyBhbmQgdHVubmVscyBkb24n
dCBoYXZlIGEgTUFDLCBpdCBzaG91bGQgbWFrZQ0KPiB1cCBhIGR1bW15IEdJRCBmb3IgdGhlIHR1
bm5lbCBpbnN0ZWFkIG9mIHVzaW5nIDAuLg0KPiANClllcy4gaXQgaXMgdGFrZW4gZnJvbSB0aGUg
TUFDIGFkZHJlc3MgYW5kIHdlIGRvbid0IGhhdmUgb25lDQpoZXJlLiBJIGRvbid0IHJlbWVtYmVy
IHRoZSBpd2NtIGNvZGUgYnkgaGVhcnQgLSBtYXliZSBhbnkgdW5pcXVlDQpHSUQgbWFrZXMgaXQg
YW5kIHRoZXJlIGlzIG5vIG5lZWQgdG8gaGF2ZSB0aGUgTUFDIHRoZXJlLg0KVW5mb3J0dW5hdGVs
eSBJIGNhbm5vdCBsb29rIGludG8gaXQgZGVlcGVyDQpyaWdodCBub3cgc2luY2UgYXdheSBmcm9t
IG15IGRlc2sgYSBsb25nIHRpbWUsIHVudGlsIGVuZCBvZg0KTWF5LiBTb3JyeSBhYm91dCB0aGF0
IGNvbmZ1c2lvbi4NCg0KQmVybmFyZA0K
