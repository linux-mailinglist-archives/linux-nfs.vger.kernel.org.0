Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E10244EAEE2
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Mar 2022 15:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236040AbiC2N6C (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 29 Mar 2022 09:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234222AbiC2N6B (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 29 Mar 2022 09:58:01 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2100.outbound.protection.outlook.com [40.107.244.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF7C2220E0;
        Tue, 29 Mar 2022 06:56:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T2L6dPuKpcvRh5dVo++AQpN/DXaaHhkJxM4RiFmu4mod9+yXVZCP1rKc////JoLhak8rxpIS0oF2evVwvoa3jZM6vR0WJXXFdkT0j1rTVzb19y5db4l2YdzoJmhDVrbiEoXpJLGMYHdMvz9SsriYT6O/mRVs0K8I4YQ62kEqKm7DH1+Ptgn+ZewbKpITlztv92V/JX3eiKTSCe/+d2qAvO7dqfdoytlVAvqhjxiSYAiSkexmil0nltpG8yw8/7UBMBm3LEVMFGtAUHZbsygX7BVS0BEWfVp7lmb+3XaP+K2/AUSkNVvxMtZgq8HejL2JVHNwxSkj2ShsP0HOq2mTWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=092RRlH5ljWI4v31ZiUR0vQjpQnnwLPr02GvHpJAy0I=;
 b=jGFUwaqZa2JEQhDsOe3+hRUIMqOb5cINbvhImEBClbJ/R5b5ftQZlxcNCCuITn8R44zzst8L65fPO89S90IA+hFUFOT0sLHHIC0HdUi/sIeoLyUvpTqFRfA8eEWW/0HlZbzd0eS8UT6akots1vx2rV2wZmiNrAiKssIK2lnsXddJTefwN41aO9q9+pcjvgdeUIfQOCMlJuDQIwtbMKd5qf03/IKIXp30KnbWiuJFXTyLPZ5ogWPUsFZqQC/Ej4j6QvvEM8401aiYR4uOxiKzEl63yy/Ai2JpAm+ZfIFBly/0ekNh6yActLa8bf4bXiEQ1vxp704f9uvgYGKqF4C/jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=092RRlH5ljWI4v31ZiUR0vQjpQnnwLPr02GvHpJAy0I=;
 b=R88WqNEaWM7L0sWf+lRgtcHqxEKNOIL3V8jQ0EQJXo7bjJoPkA8littkmTYj3IJmgdM1LAFLwxOD/OS1mcgH3tt+gnrulbl4hk8u54o70Aqc5hJ1x5JjD+2kjBwOTcoUpNYOu4MU1xBRLjVRSF46FXNeieTKgiOZ8DxrNzLkm+k=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by MWHPR13MB1472.namprd13.prod.outlook.com (2603:10b6:300:124::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.16; Tue, 29 Mar
 2022 13:56:16 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::c0b:4fda:5713:9006]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::c0b:4fda:5713:9006%7]) with mapi id 15.20.5123.016; Tue, 29 Mar 2022
 13:56:16 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "anna@kernel.org" <anna@kernel.org>,
        "chenxiaosong2@huawei.com" <chenxiaosong2@huawei.com>,
        "bjschuma@netapp.com" <bjschuma@netapp.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "liuyongqiang13@huawei.com" <liuyongqiang13@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tao.lyu@epfl.ch" <tao.lyu@epfl.ch>,
        "zhangxiaoxu5@huawei.com" <zhangxiaoxu5@huawei.com>,
        "yi.zhang@huawei.com" <yi.zhang@huawei.com>
Subject: Re: [PATCH -next 2/2] NFSv4: fix open failure with O_ACCMODE flag
Thread-Topic: [PATCH -next 2/2] NFSv4: fix open failure with O_ACCMODE flag
Thread-Index: AQHYQ16YRR1l4u4rz0W8Al1taOBdIazWVLQAgAAKuYCAAANRgA==
Date:   Tue, 29 Mar 2022 13:56:16 +0000
Message-ID: <51009f90a1694894d16abfbd31d7770c881a3f39.camel@hammerspace.com>
References: <20220329113208.2466000-1-chenxiaosong2@huawei.com>
         <20220329113208.2466000-3-chenxiaosong2@huawei.com>
         <4b0d16161fab58dcfba912eb0266a6cd1f83d47e.camel@hammerspace.com>
         <78ed2de5-84c9-708d-bab0-3bab4455593c@huawei.com>
In-Reply-To: <78ed2de5-84c9-708d-bab0-3bab4455593c@huawei.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6fdcce81-ace6-43bf-df30-08da118be4d8
x-ms-traffictypediagnostic: MWHPR13MB1472:EE_
x-microsoft-antispam-prvs: <MWHPR13MB1472EF3E64C7CEF5A1EFA1C6B81E9@MWHPR13MB1472.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uCImOqKIyULfyoAa2OgYW02BSMMjqeYxjDyiOby1t62yU5EibGfGA88EWV0FKCPPgfgVPOSy96yhn0wfVShv4MAflE1NXlg68Hdwp6d24ovbImhdgRExhNUfoNxQ+P1z6UIBLdbmancZAZ0MALpcNRNhEm/kOIlls+RdoUnME4f8ttnOi/Qn/W8pXsY9NGbp+sUcrb7MNQe7KY6xxcfwiI7IO2x7Eehl3Czfo8jn4I4dAxlDeVeO1yx7s2U2fwEfomgD4WmFu3WZcdpnxbkhIb1VJ1w7lK/fXSDa1vq0S6wu7AK4QqfEVSwpmmv66pGgwZ3rEaFYNUgSm3xT2jY5ZIBLjgqTi2qvu3jgNUSK31oNy0zJcz22lzKXrt24b2/5SS7Kx+U+hf1itHOGAZXZt5fO8cRgc8PjUWZgeIG6XyZDAITGRpgXUcvMNk3h5VVWgI5LAOObx1bkaOhSHsIqs3dKpGljSQaJckUMhqDlh5y/GlByeEjl8nRSbk7zOJ4Ay8EZNXSZQo401orAXSColLE4/osLIT4HvpU5wyyg39YNnCeiv/BmFd7LtZIovOmDeswP6KgTgW1670LaBihEG03VWsxCUZExBFlJhMt6ADDakBTTGB8OjD9BoX+hf3fByQwKvAaL/vvvMb001RV3+k3J2Dqc42eviDtrWP7/+FWSYg53o9lEKli59QGFq4vmss4DpNCFccHNqcKv8VTIhQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66556008)(66476007)(8676002)(66446008)(64756008)(76116006)(36756003)(83380400001)(8936002)(122000001)(4326008)(66946007)(5660300002)(26005)(110136005)(54906003)(186003)(38070700005)(6486002)(508600001)(2616005)(2906002)(316002)(6506007)(6512007)(71200400001)(38100700002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N2xFcHRJRGZTQXVyUUxXYzNDQUltN1ZWNkJyTit5YmtraHdNU21teHFWYWI2?=
 =?utf-8?B?bStVSkVQb0tyMTd5N3UwVitERVQ2bHZUTG1YS2NuRmRBZWV2eFBlUDltTlBo?=
 =?utf-8?B?SW5qNHE4Q2t3Q2h1Z0Z2eVB2Q0NuWXI2SHN1UzhPWVlxWnZsNVJtY2RQR21P?=
 =?utf-8?B?N055c1kzME9zZlJxTXl4QjNpRy9CM1haQjBjQW1PYk5Qa1dIeXVER216cXNG?=
 =?utf-8?B?S1VuelRzSWFQWThDb0trdXozaklwWGRWV1VHTUl2VmU4SVQ2eGFXZFBub0FQ?=
 =?utf-8?B?UCszcG9LU3Y5RmNmclAwdFRpZmhUZ0VQR0xpQ0tOdEJUOFBEVTZJTStNdDNJ?=
 =?utf-8?B?V0hDM3hoZXhCejcwdk1HYjRGSHN3MzNqSWRoVXNrVHJXaGdyZGZ5WVZuRk4x?=
 =?utf-8?B?VXN1WDJuVTdQSWRBNzYzTVMzSXdmaGFGaFNoeWpwY1F3UDBLcVg2MzdEQjhv?=
 =?utf-8?B?dlA4QjZ5QWpYTDdRUGc5RTFCYzg3bVdTL3JDMnJHMjFhTnZkdURjZ1VRdjZx?=
 =?utf-8?B?VkxuTEhlRGVIKzFDcHNGT3B0V1hMSTI5Y05OM21Sd1NJUkwrbTR2UVNCNlEv?=
 =?utf-8?B?MElmbjFVLzcyNmFCOXYycFJnQ3VEZXBVVUxjK2k5Qy9GeG1HaTVOdUpEUzdo?=
 =?utf-8?B?eVVUalZ4Rnk5NjZSWFNjL0tZU3NXMXZ6dC9WemZVMGxISHc2YW55OGRWWkV4?=
 =?utf-8?B?NXNpQktQT1RxandEL3dSYzNWYlNNUjAzdVFqbm9XbzcweUp4ekZKQWFSTFRs?=
 =?utf-8?B?WU56TjBqbWRJNkV4VXliMEFiNlNNN0puSkVBOXZyTHRQVWJYMXEzZXNWRjhz?=
 =?utf-8?B?MVR4YlIydlIraU5ESzViYkl2ZTZrVEswY2h5NVpRWXNxblVSK0t6bWpRdVBK?=
 =?utf-8?B?aWR1cU9sa21LQzFqQ3JNeW5IUVNYQ0VhZDUveWNMbGl0RG5oQjNjRjZybFlj?=
 =?utf-8?B?UVNOVFc5ZW1BNVJPRUtjdThFTUhXa05nMVc3VVpNUHdZaUFVaVZJR2Q4eWhk?=
 =?utf-8?B?dnY1WGk5dEdMK2pUZHUyT1UxVi9jcE4wQW53WHFyL3QzVEhSSzdNS1gva0ZH?=
 =?utf-8?B?c0xtcjNvMDJXQ2Rtb1dIbkU1MGdPRjBlN1hmZGdrdzhsL28vVUY4TTVLTXNG?=
 =?utf-8?B?cnF0dVR2aG96ejlrajVZQzFBbGg4OCtjRVN6MWlPTXhPY3dqc2o4dGV1V3hq?=
 =?utf-8?B?K0RsSldrNmVLdkVtWUp0UG84YmxDbjE1K0g5Q1RHVkdwelhyaW9nQks2ZURs?=
 =?utf-8?B?bmdrMTIvSDBqbVBmZ1VDdVdsc1VVU0ZrSFdsc082YVNXUm1aam4zZDFxblF0?=
 =?utf-8?B?VmVOL2NBWHYwak9QaFQ1Q0lKTHJpb3YyUVl0eTJQQ2lqOGNhMjBrV3ZtZVJv?=
 =?utf-8?B?U2lBdzFCQ2NObFJTZ1k2aXdkSkNqdXlvNUdQb1ZRM09CZElEdE9OZjQ2d01r?=
 =?utf-8?B?UTlOaVo2RnhUWC9WYjh4TUIwVWlaT3ovMHBQZW1MR216RXViWk5xdDFxTzUx?=
 =?utf-8?B?Z3pEWDFDN1dvU3pzYXVQMGVkemVrL0IweWpWbCtZYUhKaWQ2ODAxY3FYYTc2?=
 =?utf-8?B?TUQybHZKSzhoMUpiK0p4SDVlL2hUVVoxalZxSk9HbE5DUVVkYkZyL3dvZ3VD?=
 =?utf-8?B?c3FQVUZUc1NFWmUrbmRaTlNJT1RsUjhBWHk2UXI3c0N3MGVVNngxZWNUWlhH?=
 =?utf-8?B?bEFFRnhaalZiQTlDcTRlZS9PNThCa2Rid25UdldLUUJtOUo3NDNSd3UwUnBG?=
 =?utf-8?B?SjY0clhTYjlUY2RpVTNsU29WZVh1VFJPdnNINE5FakhaNFliaWJuV3U0blNw?=
 =?utf-8?B?T2pERHUxUTNQR3EvZGJnRHFRbHdsYW1TVitkSHdzSkJEYXp5ZmQwM3BsN0NB?=
 =?utf-8?B?M0oxWDVFNk9xVlA0ZlhXVW9rT0VIMUtqZlh2MkN6S0czaU1uc2RXdktDSDBl?=
 =?utf-8?B?MjdCcmRtSnh5NytxdTM1V0k4cjNNajlMaSs2eSsvSjZOSnVhM1E0V1orTWc1?=
 =?utf-8?B?WHRUZUZDNFJPYkZDZGFXSlhWbEdYUjA2SysxUllwNTRRNi94b2U2N3VJUG42?=
 =?utf-8?B?dnBzaXNNR05ENDlrckplbkJGM09tTjZoQVZiOURYcUdSS2NxbkhEOVRHRjNJ?=
 =?utf-8?B?VnBpOVJmZmNaSGRIYTdjSyt2OVVBWVBLTFNSeGNJS2ZKZG80L3JmSXBMTXVZ?=
 =?utf-8?B?TGZQSnVTd2grUnBuYzBNd2M4SHpFUURsT1ZHSzNMZndVTDRpYTZqeERJZFJU?=
 =?utf-8?B?cm1JU2Fvb25wWWtKd2pRaWdMTGVhRmxFb0wzVjlBZzJVVG5SRC90dnFRaW9p?=
 =?utf-8?B?R0I3bHdtOFhRWTZWWFgyVXRqaGRjd3ZPbzhFNDZSSmRKM3c4UzBvci9xYjB6?=
 =?utf-8?Q?Nxkp5QnQUVVeXuBg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F7CB5361CD337B479E34B06A266D0C5A@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fdcce81-ace6-43bf-df30-08da118be4d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2022 13:56:16.2172
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rIWu5E2nHKRw127Tm9SN+b30JwY9hk9KXAXFzgCTiGA3QlbZOYtQNFKrNCBYJGx7JgWvcy3QNOUsDha3lncRzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR13MB1472
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIyLTAzLTI5IGF0IDIxOjQ0ICswODAwLCBjaGVueGlhb3NvbmcgKEEpIHdyb3Rl
Og0KPiDlnKggMjAyMi8zLzI5IDIxOjA1LCBUcm9uZCBNeWtsZWJ1c3Qg5YaZ6YGTOg0KPiA+IE5v
LiBUaGlzIHdpbGwgbm90IGZpdCB0aGUgZGVmaW5pdGlvbiBvZiBvcGVuKDIpIGluIHRoZSBtYW5w
YWdlLg0KPiA+IA0KPiA+IMKgwqDCoMKgwqDCoMKgIExpbnV4IHJlc2VydmVzIHRoZSBzcGVjaWFs
LCBub25zdGFuZGFyZCBhY2Nlc3MgbW9kZSAzwqANCj4gPiAoYmluYXJ5wqAgMTEpwqAgaW4NCj4g
PiDCoMKgwqDCoMKgwqDCoCBmbGFnc8KgIHRvIG1lYW46IGNoZWNrIGZvciByZWFkIGFuZCB3cml0
ZSBwZXJtaXNzaW9uIG9uIHRoZQ0KPiA+IGZpbGUgYW5kIHJl4oCQDQo+ID4gwqDCoMKgwqDCoMKg
wqAgdHVybiBhIGZpbGUgZGVzY3JpcHRvciB0aGF0IGNhbid0IGJlIHVzZWQgZm9yIHJlYWRpbmcg
b3INCj4gPiB3cml0aW5nLsKgIFRoaXMNCj4gPiDCoMKgwqDCoMKgwqDCoCBub25zdGFuZGFyZMKg
IGFjY2VzcyBtb2RlIGlzIHVzZWQgYnkgc29tZSBMaW51eCBkcml2ZXJzIHRvDQo+ID4gcmV0dXJu
IGEgZmlsZQ0KPiA+IMKgwqDCoMKgwqDCoMKgIGRlc2NyaXB0b3IgdGhhdCBpcyB0byBiZSB1c2Vk
IG9ubHkgZm9yIGRldmljZS1zcGVjaWZpYw0KPiA+IGlvY3RsKDIpwqAgb3BlcmHigJANCj4gPiDC
oMKgwqDCoMKgwqDCoCB0aW9ucy4NCj4gwqA+IFlvdXIgcGF0Y2ggd2lsbCBub3cgY2F1c2UgRk1P
REVfUkVBRCBhbmQgRk1PREVfV1JJVEUgdG8gYmUgc2V0IG9uDQo+IHRoZQ0KPiDCoD4gZmlsZSwg
YWxsb3dpbmcgdGhlIGZpbGUgZGVzY3JpcHRvciB0byBiZSB1c2FibGUgZm9yIEkvTy4NCj4gDQo+
IFJlcHJvZHVjZXI6DQo+IGBgYA0KPiDCoMKgIDEuIG1vdW50IC10IG5mcyAtbyB2ZXJzPTQuMiAk
c2VydmVyX2lwOi8gL21udC8NCj4gwqDCoCAyLiBmZCA9IG9wZW4oIi9tbnQvZmlsZSIsIE9fQUND
TU9ERXxPX0RJUkVDVHxPX0NSRUFUKSA9IDMNCj4gwqDCoCAzLiBjbG9zZShmZCkNCj4gwqDCoCA0
LiBmZCA9IG9wZW4oIi9tbnQvZmlsZSIsIE9fQUNDTU9ERXxPX0RJUkVDVCkgPSAtMQ0KPiBgYGAN
Cj4gDQo+IFdoZW4gZmlyc3RseSBvcGVuIHdpdGggT19BQ0NNT0RFfE9fRElSRUNUIGZsYWdzOg0K
PiBgYGBjDQo+IMKgwqAgcGF0aF9vcGVuYXQNCj4gwqDCoMKgwqAgb3Blbl9sYXN0X2xvb2t1cHMN
Cj4gwqDCoMKgwqDCoMKgIGxvb2t1cF9vcGVuDQo+IMKgwqDCoMKgwqDCoMKgwqAgYXRvbWljX29w
ZW4NCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqAgbmZzX2F0b21pY19vcGVuDQo+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBjcmVhdGVfbmZzX29wZW5fY29udGV4dA0KPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGZfbW9kZSA9IGZsYWdzX3RvX21vZGUNCj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBhbGxvY19uZnNfb3Blbl9jb250ZXh0KC4uLiwgZl9tb2RlLCAuLi4pDQo+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGN0eC0+bW9kZSA9IGZfbW9kZSAvLyBGTU9E
RV9SRUFEfEZNT0RFX1dSSVRFDQo+IGBgYA0KPiANCj4gV2hlbiBzZWNvbmRseSBvcGVuIHdpdGgg
T19BQ0NNT0RFfE9fRElSRUNUIGZsYWdzOg0KPiBgYGBjDQo+IMKgwqAgcGF0aF9vcGVuYXQNCj4g
wqDCoMKgwqAgZG9fb3Blbg0KPiDCoMKgwqDCoMKgwqAgdmZzX29wZW4NCj4gwqDCoMKgwqDCoMKg
wqDCoCBkb19kZW50cnlfb3Blbg0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoCBuZnM0X2ZpbGVfb3Bl
bg0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZl9tb2RlID0gZmlscC0+Zl9tb2RlIHwgZmxh
Z3NfdG9fbW9kZShvcGVuZmxhZ3MpDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBhbGxvY19u
ZnNfb3Blbl9jb250ZXh0KC4uLiwgZl9tb2RlLCAuLi4pDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgY3R4LT5tb2RlID0gZl9tb2RlIC8vIEZNT0RFX1JFQUR8Rk1PREVfV1JJVEUNCj4g
YGBgDQo+IA0KPiBCZWZvcmUgbWVyZ2luZyB0aGlzIHBhdGNoLCB3aGVuIGZpcnN0bHkgb3Blbiwg
d2UgZG9lcyBub3Qgc2V0DQo+IEZNT0RFX1JFQUQgDQo+IGFuZCBGTU9ERV9XUklURSB0byBmaWxl
IG1vZGUgb2YgY2xpZW50LCBGTU9ERV9SRUFEIGFuZCBGTU9ERV9XUklURQ0KPiBqdXN0IA0KPiBi
ZSBzZXQgdG8gY29udGV4dCBtb2RlLg0KPiANCj4gQWZ0ZXIgbWVyZ2luZyB0aGlzIHBhdGNoLCB3
aGVuIHNlY29uZGx5IG9wZW4sIEkganVzdCBkbyB0aGUgc2FtZQ0KPiB0aGluZywgDQo+IGZpbGUg
bW9kZSBvZiBjbGllbnQgd2lsbCBub3QgaGF2ZSBGTU9ERV9SRUFEIGFuZCBGTU9ERV9XUklURSBi
aXRzLA0KPiBmaWxlIA0KPiBkZXNjcmlwdG9yIGNhbid0IGJlIHVzZWQgZm9yIHJlYWRpbmcgb3Ig
d3JpdGluZy4NCg0KSSBzZWUuIE9LLCBJJ2xsIHByb2JhYmx5IG5vdCBhcHBseSB0aGlzIGZvciB0
aGUgbWVyZ2Ugd2luZG93IChzaW5jZSBJJ20NCnByZXR0eSBtdWNoIHF1ZXVlZCB1cCB0byBzZW5k
IHRoZSBwdWxsIHJlcXVlc3QgYXQgdGhpcyBwb2ludCksIGJ1dCBpdA0KbWlnaHQgZ28gaW4gYXMg
YSBidWcgZml4IGluIHJjMS4NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGll
bnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5j
b20NCg0KDQo=
