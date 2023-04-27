Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07FF06F0B56
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Apr 2023 19:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244454AbjD0RrX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Apr 2023 13:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244565AbjD0RrH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Apr 2023 13:47:07 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6139A35A5;
        Thu, 27 Apr 2023 10:46:38 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33RHiPW4012212;
        Thu, 27 Apr 2023 17:46:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : date :
 message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version : subject; s=pp1;
 bh=zUlxwUKirGIzx/T12zGaL2C7Nw9K4AsVJ64iRb9S8tc=;
 b=REA3ol6OfV2RPChw2LE/unTtzLwZ5p7oNEAucMkIBvgSHgzLXqarNomYpokkUj54uJYN
 lyv/YYvP6chj25q6kz6gGeRFL53xOitjw/IsqzV1Mr1Cu92svQSJygczjHc9otYn4Fu/
 07t20ilCdSeSidKByv+98TJ8w35UGDyLYGsnjeCC5ESGNElMQsJ9WqYnduy2/SPfNCO4
 XVCYo83Q2lbFIrClcQ4pGuNOv2NfJgQhUr3Y/dAk+sqn6rQDlFaTM95pmsfKv/a3WkYF
 IcDg7vZOZxhLe37v44zPdBysU3VZdiRkTTNChFU4V4IDrHZi9BYclsJIGE+iRnshbDiz 7A== 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2047.outbound.protection.outlook.com [104.47.73.47])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q7tctfx4b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Apr 2023 17:46:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FILAY5Abghbszv+V7mC5++yXr7qcG3x2UMQETHn2p8GqK2FpHGjZ8VEsbSYNshFCR+GTHK4CvcA4EfuvF+F2U4+0dYef3sEXz34S+eOiXXLFGwtnoDndmHfAdyfwEsYjeL9IMpnvjIFg/qMk7XweffStJvV2NrYj/VaE7kVlVX0ReLWD/Fnhpg1zlcD6U5rvYCXelUUTHq/PIlSO+zIef51P6E7iAGguWMPllQI6gbkC7dDDUijGyu0YTN5EMZc1K6qvBP2FZQs5nDkY0hMVz4kbbwtYUbWE3+fy+ItcKEreKT5WdGw61NSPg8Htcf2B61XVivWFbxVJvcti/yuO/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zUlxwUKirGIzx/T12zGaL2C7Nw9K4AsVJ64iRb9S8tc=;
 b=QgeBJN8Vj1OnDmfUi2w/CjXdJbBl6ZmW25zOAXokQ4jbbzoth5O1z8VeSM+I7ddm3aof1TZ/Tl6Suud6XroOgxoYNQSnrya9D3rdaU2ZXYt/DSnNs6JYzKpy3HYIgtfgaH1LNjcqp+N0reZSZS5zhWZOuR1H49I2PSadBRWshd88as9sBsybOEKb/7YvZ79/G0f11j0mA2Jv4DL1ysj7lUr1rgyw6vVkaitXme5LWVPpZGlDLl8CRM7ppFE//4OVdAaPDTryUNoELXeSc5R1OtyYDZpE7J79cHsPz/592hhno8pDyV+RNBsGuTrTRWUrNSQvm5fYWIqCcveIv/BJzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from SA0PR15MB3919.namprd15.prod.outlook.com (2603:10b6:806:91::20)
 by BLAPR15MB3827.namprd15.prod.outlook.com (2603:10b6:208:254::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22; Thu, 27 Apr
 2023 17:46:06 +0000
Received: from SA0PR15MB3919.namprd15.prod.outlook.com
 ([fe80::5ced:e1f2:71bf:a4f0]) by SA0PR15MB3919.namprd15.prod.outlook.com
 ([fe80::5ced:e1f2:71bf:a4f0%7]) with mapi id 15.20.6340.021; Thu, 27 Apr 2023
 17:46:06 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Chuck Lever <cel@kernel.org>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Thread-Topic: [EXTERNAL] [PATCH RFC] RDMA/core: Store zero GIDs in some cases
Thread-Index: AQHZeSvMTgGKXNusKUa8sxq2phfXFq8/bMjQ
Date:   Thu, 27 Apr 2023 17:46:06 +0000
Message-ID: <SA0PR15MB39193598A4C64E84F6E07582996A9@SA0PR15MB3919.namprd15.prod.outlook.com>
References: <168261567323.5727.12145565111706096503.stgit@oracle-102.nfsv4bat.org>
In-Reply-To: <168261567323.5727.12145565111706096503.stgit@oracle-102.nfsv4bat.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR15MB3919:EE_|BLAPR15MB3827:EE_
x-ms-office365-filtering-correlation-id: 765a3327-f719-4191-e47d-08db47474740
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OFFXRsDMA+CmoFzPuUzmKW7UvAVlcvyy230Ch6gzUM7DfNx8yzwabMxLH6l0uG2+GLruLpVzGZK0XMwtuOmSbDLsAkD17Vdmp0szdiPQ/XEq3RgZPzl20Hzw42IcpL+sg592gFsA2hOUo7H78KdLsaWwl4J0CvKnOOJK4dd1qIT9EPquWHcxOZhW0KlDHieumVxExCTm/JjvnHuNMJbh8i2t+TODlQgskj6DkTxrhxA8mSbV+INK3AJo/j57vK4mUt279sWhDAzTNbUZI+O6vTsTIlRPlIuTetgV+TcSnV4Fx+lpdVC0nq2IKWHa4tf3OGJVIzkDUdMZB3tZ8+GJT3mZ/7Bx3OXVPTWD1GmoFRSpagitu0oU0r8CQV6aTYWCJEoiwXqv+wLQ4H6EiDVwlcc+H4h1v6eoR999mdf6lX/fWcvNlwsIPdw9JacZOn+BnMSMKmUeKAHzR87Knx5W4z94jB+sudWOhWQi5fxOKdOeLEWIZ2IW+806Os6vfAlWMdZjvJIUtXSY2F+3+cSfGXhwQvCGdpCixMNp0z/Vy6RvYwAOPBBqQCLn0u02EofszjqqkBMW4HA4OZb9Q+jSZGo4cPcA65fVNKClshEpw5Z22RQItv5uoN/8hSSMwZPZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR15MB3919.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(396003)(346002)(366004)(39860400002)(451199021)(53546011)(6506007)(9686003)(186003)(55016003)(2906002)(38070700005)(54906003)(478600001)(8676002)(38100700002)(316002)(41300700001)(122000001)(8936002)(52536014)(66946007)(76116006)(5660300002)(83380400001)(66556008)(66476007)(66446008)(64756008)(33656002)(4326008)(6916009)(7696005)(71200400001)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?djl4SGcyWnprVkJKZ2dwcDdYaCt5OCt6RnNJRnlENzYrek83SmFWRU1VTGxW?=
 =?utf-8?B?cGliMXc1dnU0eFNFRlFlRzZQT2NieGVuaHQrOWMzKzR3NjBCcm9TWGxsSlNM?=
 =?utf-8?B?RTVSOXZDRGlTdDVrR3d4MThCWDFkKzhMd0JucGhjNlZvVWp5MkN6Qjk2d2l4?=
 =?utf-8?B?NndRT2ROM0pudXlPR0ZnQkNwRkRTRHdmVmUvbjg1VTRpdTU1WTNwMi93Z3JO?=
 =?utf-8?B?aDJTUGZadlVqbWx2eWJKeGtKbm0vbmVNU3hBTm5EVGI0c3YrRGJ3TTlyNWt0?=
 =?utf-8?B?SitkWjJWZnNLbXRvU3BubTh2NkdCYThxckhSYjd2cmhFOFFxYjNTUTg1Qlkv?=
 =?utf-8?B?cEphQi92RkJ6V1RZUTJCUzNnMXY4OWZVRExWcXI5WWE5bVhmWlpWZDUyRlFj?=
 =?utf-8?B?NlE1VGVrQVZtSFd3dENrd28rYUFLN0Z6VmVMUTF1ZS9oc3JRNVE1MjVNN0Rh?=
 =?utf-8?B?eUJQZklWTUNQczhFWkY5U0grM3Q4MitUN21naHFHbTBDT0ZkTjNjQVdjajl0?=
 =?utf-8?B?Q3QrOW96Nk5ocFRYSEgyU2hjcGNxNGVYUjJpWWdiZHVoRXZmTUZWR05CZVVp?=
 =?utf-8?B?U2ltL3B3d1BVdUtwamQ2aWdYd01iOStrNGpZSjEvSG1NTnBWNU96NHI4bUlM?=
 =?utf-8?B?NFZoQksxSHp2MmN5STduUE9qUXNJbFpuSEVRUWcwOGVkYVJIZjhjWlpQZEZn?=
 =?utf-8?B?Z0duS09wVzlUUFJBNGlOdHlXWjdvTlgzS2ZPUis4K3pFTjZFSXJGd1pzSTQy?=
 =?utf-8?B?cjJQZ1ZQTDAzcUJkQ1RiMHlSK3lkUEZtNEdrZ1ZXcHA1ZXFIZmswSWRBLzdm?=
 =?utf-8?B?M0hHbVpLTTB6WERDSm9BSEpGV3J5QmNBNm5yR0VSejdYdWtpWldrTWNKQTB2?=
 =?utf-8?B?QlR0WHJFbDE0L2lvZlhZMTJIeExUWUhNYzZJbFhTSWpuOXkzYU8zQ1I4RHkz?=
 =?utf-8?B?MWdUTlkrOGdrcWFDT0hXRS9HNkZwbk04UU9oNzZJTkl5WHQ0Wis3QnRBSWtL?=
 =?utf-8?B?RVhrWi9NNFRpV1ZVZjhheVhudDh4K29sWkphVzQ1Nnl0SGFXbk1FZmhYN3lO?=
 =?utf-8?B?eE4xc3NLSmpuLzErTHlRV0FpeGZwRE1qdnBhcmhpVTdWUHIvaDIyWmM4K1k2?=
 =?utf-8?B?d1Z5enBiRUw0U0NrcWFGSEVraVY4eHJ6aFVxdTlBS0I3UmRZMkcvMDhyQmcx?=
 =?utf-8?B?TWdaY0J0K3NwdmoyYjEvV0FlMWNJZVJCVVUyZWJ3QlFXVWN2VTFXN2E5cHRN?=
 =?utf-8?B?ZllQblJtTUhEWHdReUJlVmR0bGFra2h0MUJKa2NLdVlNNmxEVkRtVWYwdGZx?=
 =?utf-8?B?ek9BV25YVnFXakJRSE1OMG1USktKaVpXcUpLOE9EdnNzNy93aVpyQXhaaERH?=
 =?utf-8?B?c3RmWk52UU9rNzh1b0JQbWZZbkpodEY1bGhNNkdyaVEyZndZd2lXblBUcWgw?=
 =?utf-8?B?YU9RV0VvdFhTNkI0TDdOM2ZuVXNBa3A0NXduMDlCeEdCditoYnBRZTVZK2tx?=
 =?utf-8?B?Qys3bjFrQWFHQ3g0UmtsY1JxdDlqbVZMRlo2amtrVnRjMmg4OW0xYmRLZkR2?=
 =?utf-8?B?bGJMQ2ZsZUNNVUd3NVdlT0VHTE53SDZKanZhZlROa09SaW1yQlZSamlIR3du?=
 =?utf-8?B?L1gvcmlBSGRKT1ZvNFR3NFQxZG96dW1LUG5KdFk5bk5mRmdNa2VSa0g0ZE05?=
 =?utf-8?B?NjZDQ2Y5djZxem5kZm1mR3FORWRsUFNUelZ5Y0FFWVAwT3ZTOUo0bzdFa3hm?=
 =?utf-8?B?L0loRUlON1lJa05DSEJtaEtienkxWlFWbXc4MVkrVDVRZVZtM21uaVZZeHFO?=
 =?utf-8?B?cUI0RktJVEcrNmlQSHBRU1Q1MVl2UEVtRzRiYnlGYk1WM2UwZlV3YTFMSnNl?=
 =?utf-8?B?Zk13Ym9QM29sSDYwVG5vS2RkVlVWaGdIN3p2Um00Qk1XVzhDYnN6WnRUZE9R?=
 =?utf-8?B?bXpMeDFUSWtDMUQ4VktRQzc0V3FnbXloZGZmYkRPdGR2UFpRa1MxczRpRTVT?=
 =?utf-8?B?V3Y5M25xOWd1dUsrMGZCUWhrNDRtcVVlZkpsaGxvd3JjSnRjRlBON3RFRlBK?=
 =?utf-8?B?TDNYQURobDBUOWF1cmkvTDZGVzZTOGpPUUpYS1dQejJSWFFmYVJlcmhSYmhU?=
 =?utf-8?B?cW01cUtBOGxNd0ZPazgrQzdjY2FzeGFxRnUvalNpUFlNVUhqTndGWStHNVdV?=
 =?utf-8?Q?ReIqAwst9K4N/p8NJFm/TCzs/TKiCrg6n5aG/1GHoyDG?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR15MB3919.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 765a3327-f719-4191-e47d-08db47474740
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2023 17:46:06.6645
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JT4TzLp5tBENO9ic/wQ3mJwcCJBLqqKYgDCvWPY45D5cOCG8vGxDsUQcN6l0RDE1IkI6U5LYGDU5qSHSgLywuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR15MB3827
X-Proofpoint-GUID: Uesz3xb_dP2WWEqMsB9Nol8Q2TvJtwOE
X-Proofpoint-ORIG-GUID: Uesz3xb_dP2WWEqMsB9Nol8Q2TvJtwOE
Subject: RE:  [PATCH RFC] RDMA/core: Store zero GIDs in some cases
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-27_07,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 clxscore=1011 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 bulkscore=0 spamscore=0 adultscore=0 impostorscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304270154
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ2h1Y2sgTGV2ZXIgPGNl
bEBrZXJuZWwub3JnPg0KPiBTZW50OiBUaHVyc2RheSwgMjcgQXByaWwgMjAyMyAxOToxNQ0KPiBU
bzogQmVybmFyZCBNZXR6bGVyIDxCTVRAenVyaWNoLmlibS5jb20+DQo+IENjOiBsaW51eC1yZG1h
QHZnZXIua2VybmVsLm9yZzsgbGludXgtbmZzQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBb
RVhURVJOQUxdIFtQQVRDSCBSRkNdIFJETUEvY29yZTogU3RvcmUgemVybyBHSURzIGluIHNvbWUg
Y2FzZXMNCj4gDQo+IEZyb206IEJlcm5hcmQgTWV0emxlciA8Ym10QHp1cmljaC5pYm0uY29tPg0K
PiANCj4gVHVubmVsIGRldmljZXMgaGF2ZSB6ZXJvIEdJRHMsIHNvIHNraXAgdGhlIHplcm8gR0lE
IGNoZWNrIHdoZW4NCj4gc2V0dGluZyB1cCBzb2Z0IGlXQVJQIG92ZXIgYSB0dW5uZWwgZGV2aWNl
Lg0KPiANCj4gU3VnZ2VzdGVkLWJ5OiBCZXJuYXJkIE1ldHpsZXIgPGJtdEB6dXJpY2guaWJtLmNv
bT4NCj4gU2lnbmVkLW9mZi1ieTogQ2h1Y2sgTGV2ZXIgPGNodWNrLmxldmVyQG9yYWNsZS5jb20+
DQo+IC0tLQ0KPiAgZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvY2FjaGUuYyAgICAgIHwgICAgNCAr
KystDQo+ICBkcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd19tYWluLmMgfCAgICAxICsNCj4g
IGluY2x1ZGUvcmRtYS9pd19jbS5oICAgICAgICAgICAgICAgICB8ICAgIDkgKysrKysrKystDQo+
ICAzIGZpbGVzIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvY2FjaGUuYw0KPiBiL2RyaXZl
cnMvaW5maW5pYmFuZC9jb3JlL2NhY2hlLmMNCj4gaW5kZXggMmU5MWQ4ODc5MzI2Li4yNDkzY2E0
ZjI3MzkgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaW5maW5pYmFuZC9jb3JlL2NhY2hlLmMNCj4g
KysrIGIvZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvY2FjaGUuYw0KPiBAQCAtNDEsNiArNDEsNyBA
QA0KPiAgI2luY2x1ZGUgPG5ldC9hZGRyY29uZi5oPg0KPiANCj4gICNpbmNsdWRlIDxyZG1hL2li
X2NhY2hlLmg+DQo+ICsjaW5jbHVkZSA8cmRtYS9pd19jbS5oPg0KPiANCj4gICNpbmNsdWRlICJj
b3JlX3ByaXYuaCINCj4gDQo+IEBAIC00NDEsNyArNDQyLDggQEAgc3RhdGljIGludCBhZGRfbW9k
aWZ5X2dpZChzdHJ1Y3QgaWJfZ2lkX3RhYmxlICp0YWJsZSwNCj4gIAkgKiBsZWF2ZSBvdGhlciB1
bnVzZWQgZW50cmllcyBhcyB0aGUgemVybyBHSUQuIENvbnZlcnQgemVybyBHSURzIHRvDQo+ICAJ
ICogZW1wdHkgdGFibGUgZW50cmllcyBpbnN0ZWFkIG9mIHN0b3JpbmcgdGhlbS4NCj4gIAkgKi8N
Cj4gLQlpZiAocmRtYV9pc196ZXJvX2dpZCgmYXR0ci0+Z2lkKSkNCj4gKwlpZiAocmRtYV9pc196
ZXJvX2dpZCgmYXR0ci0+Z2lkKSAmJg0KPiArCSAgICEoYXR0ci0+ZGV2aWNlLT5pd19kcml2ZXJf
ZmxhZ3MgJiBJV19GX1NUT1JFXzBHSUQpKQ0KPiAgCQlyZXR1cm4gMDsNCj4gDQo+ICAJZW50cnkg
PSBhbGxvY19naWRfZW50cnkoYXR0cik7DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2luZmluaWJh
bmQvc3cvc2l3L3Npd19tYWluLmMNCj4gYi9kcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd19t
YWluLmMNCj4gaW5kZXggZGFjYzE3NDYwNGJmLi44NDJhMDM5ZmE0NTcgMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X21haW4uYw0KPiArKysgYi9kcml2ZXJzL2lu
ZmluaWJhbmQvc3cvc2l3L3Npd19tYWluLmMNCj4gQEAgLTM1OSw2ICszNTksNyBAQCBzdGF0aWMg
c3RydWN0IHNpd19kZXZpY2UgKnNpd19kZXZpY2VfY3JlYXRlKHN0cnVjdA0KPiBuZXRfZGV2aWNl
ICpuZXRkZXYpDQo+IA0KPiAgCS8qIERpc2FibGUgVENQIHBvcnQgbWFwcGluZyAqLw0KPiAgCWJh
c2VfZGV2LT5pd19kcml2ZXJfZmxhZ3MgPSBJV19GX05PX1BPUlRfTUFQOw0KPiArCWJhc2VfZGV2
LT5pd19kcml2ZXJfZmxhZ3MgPSBJV19GX1NUT1JFXzBHSUQ7DQo+IA0KVGhhdCBvdmVyd3JpdGVz
IHRoZSBmaXJzdCBhc3NpZ25tZW50LiBQcm9iYWJseSBiZXR0ZXINCid8PSBJV19GX1NUT1JFXzBH
SUQ7JyA/IE9yIHB1dCB0aGVtIG9uIG9uZSBsaW5lLi4uDQoNCg0KPiAgCXNkZXYtPmF0dHJzLm1h
eF9xcCA9IFNJV19NQVhfUVA7DQo+ICAJc2Rldi0+YXR0cnMubWF4X3FwX3dyID0gU0lXX01BWF9R
UF9XUjsNCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvcmRtYS9pd19jbS5oIGIvaW5jbHVkZS9yZG1h
L2l3X2NtLmgNCj4gaW5kZXggMDNhYmQzMGU2YzhjLi5jNDhmMmNiZTM3YjUgMTAwNjQ0DQo+IC0t
LSBhL2luY2x1ZGUvcmRtYS9pd19jbS5oDQo+ICsrKyBiL2luY2x1ZGUvcmRtYS9pd19jbS5oDQo+
IEBAIC05MCw3ICs5MCwxNCBAQCBlbnVtIGl3X2ZsYWdzIHsNCj4gIAkgKiByZXNlcnZlIHRoZSBw
b3J0LiAgVGhpcyBpcyByZXF1aXJlZCBmb3Igc29mdCBpd2FycA0KPiAgCSAqIHRvIHBsYXkgaW4g
dGhlIHBvcnQgbWFwcGVkIGl3YXJwIHNwYWNlLg0KPiAgCSAqLw0KPiAtCUlXX0ZfTk9fUE9SVF9N
QVAgPSAoMSA8PCAwKSwNCj4gKwlJV19GX05PX1BPUlRfTUFQID0gQklUKDApLA0KPiArDQo+ICsJ
LyoNCj4gKwkgKiBUaGlzIGZsYWcgYWxsb3dzIHRoZSBpbnNlcnRpb24gb2YgemVybyBHSURzIGlu
dG8gdGhlDQo+ICsJICogc3RvcmVkIEdJRCB0YWJsZS4gVGhhdCBpcyBuZWVkZWQgdG8gZW5hYmxl
IHNvZnQgaVdBUlANCj4gKwkgKiBvbiB0dW5uZWwgZGV2aWNlcy4NCj4gKwkgKi8NCj4gKwlJV19G
X1NUT1JFXzBHSUQgPSBCSVQoMSksDQo+ICB9Ow0KPiANCj4gIC8qKg0KPiANCg0K
