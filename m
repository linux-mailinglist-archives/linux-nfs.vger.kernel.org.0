Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EFA17985D9
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Sep 2023 12:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbjIHK2f (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 8 Sep 2023 06:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235744AbjIHK2e (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 8 Sep 2023 06:28:34 -0400
Received: from esa4.fujitsucc.c3s2.iphmx.com (esa4.fujitsucc.c3s2.iphmx.com [68.232.151.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1C01FC9
        for <linux-nfs@vger.kernel.org>; Fri,  8 Sep 2023 03:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1694168878; x=1725704878;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JFAXq34u9b+uTeTtOahXJzbnLEHmG0CN+u4lL3DoGW4=;
  b=mlzMcT/Z9WQMGig0NcjMrRbB2FRZAeqCHsTPILB5TqqKQtZs9CYZ7xij
   5ZP8ajvxZOva4RR9akXRoyZ7FkN9y36wd/kOqEqS/6wQ2eevlhiIIs7zp
   bXc0MIuCYZIiMCDX4+gyVJ7tFJD1gcEvrT2G71Ng9yuNA1hL1rFa0lRbZ
   qTu5rWmDYFu3KlHun6w/9VEQn3TlCZ2fORlWE/jH4dtK9qxuMcBdH2ry4
   C7M9UnbXZYbylmbMXJgWYjwQvMl0UjRpNt/OgAGWvVgf6XmXQ8Jhuio4t
   ndpZEzxgV7obmdUItFVRHC9HZr/c6PQGLpJzj4D/vm+IP9N5Q7cVuhIr8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="7638453"
X-IronPort-AV: E=Sophos;i="6.02,236,1688396400"; 
   d="scan'208";a="7638453"
Received: from mail-os0jpn01lp2107.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.107])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2023 19:26:39 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aju5tOyqfYlInkKNxw30q2RwzhUmuR7qxqptAlEgr0mBHug7aJawm/kc2yReWOyJDx9Il2s96vT9pjqFgwE81oWe7rCoFit44x7isl/ZYsl69wYy1aNxf0uaovblR5fsPkhSuGNtnGeT9W9FNFq0sOQ/FE92VVEX9ENxvUGFhT9CTm2qBtSNKuW8DIA80+ypyFDeL/Cw94WRXFypDHgPqCyMmWQ67Or4Ao7rmhOIFnsMAP2BEL26x1tMnJauvzaBVIdU9w1at2Bm5/xvnN8foemx4whbCoukgIxpXuCX3ueA3MQnJjrlKcXdYcKEIt/YLTpfQh8u4gBfmhl6lJs9Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JFAXq34u9b+uTeTtOahXJzbnLEHmG0CN+u4lL3DoGW4=;
 b=auKu5+dd7wmdq+Ktsvv0XuN91APvcwxcH9efkc1UJNp4QjVINUr7f8C6486EBNMMd+KpAEDO0KwXkvLKPALg/3DOIgdM1ju4leEt+H9BsrdL7AQiU7ZD2AtJE9KMnHVCEM11OPdrvLHvVukl1VXYUHcpdmx4iDQLrf5ncwKSthaWe9G12+fNPWwrUQcWej42w2+Uh2WR0qOaEdL7AbZ3AR797IzH/ertCPe76vTikiWDFDdvQFgU/Kd9V2Oz1voh8g4KXI1/K2/WlCXhtvxxgksilcEIZNDdBQWt1u/J324U3E+K90Q/xft8Ol1pa2e81WmTo/ZHoTjdxWHdje7AOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB5640.jpnprd01.prod.outlook.com (2603:1096:604:c1::6)
 by TYCPR01MB11865.jpnprd01.prod.outlook.com (2603:1096:400:38c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 8 Sep
 2023 10:26:37 +0000
Received: from OS3PR01MB5640.jpnprd01.prod.outlook.com
 ([fe80::8b3d:4589:cbbe:5f19]) by OS3PR01MB5640.jpnprd01.prod.outlook.com
 ([fe80::8b3d:4589:cbbe:5f19%4]) with mapi id 15.20.6768.029; Fri, 8 Sep 2023
 10:26:36 +0000
From:   "Hanxiao Chen (Fujitsu)" <chenhx.fnst@fujitsu.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>
CC:     Jeff Layton <jlayton@kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: =?gb2312?B?u9i4tDogW1JGQyBQQVRDSCB2Ml0gbmZzdjQ6IEFkZCBzdXBwb3J0IGZvciB0?=
 =?gb2312?Q?he_birth_time_attribute?=
Thread-Topic: [RFC PATCH v2] nfsv4: Add support for the birth time attribute
Thread-Index: AQHZ3K8mF/t8v78jIUOe4QDTW5X6bLAQw2Ng
Date:   Fri, 8 Sep 2023 10:26:35 +0000
Message-ID: <OS3PR01MB5640EFE0A84A93C676FC7454E6EDA@OS3PR01MB5640.jpnprd01.prod.outlook.com>
References: <20230901083421.2139-1-chenhx.fnst@fujitsu.com>
In-Reply-To: <20230901083421.2139-1-chenhx.fnst@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?gb2312?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?gb2312?B?NTBfQWN0aW9uSWQ9NGM0NjU3YTItYmZkYS00MmE4LWFmMDktZjQ4Zjg4MTBj?=
 =?gb2312?B?MmZkO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?gb2312?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?gb2312?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?gb2312?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?gb2312?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?gb2312?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFRKlWPz87TVNJ?=
 =?gb2312?B?UF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBf?=
 =?gb2312?B?U2V0RGF0ZT0yMDIzLTA5LTA4VDEwOjIyOjMyWjtNU0lQX0xhYmVsX2E3Mjk1?=
 =?gb2312?B?Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9TaXRlSWQ9YTE5ZjEy?=
 =?gb2312?Q?1d-81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB5640:EE_|TYCPR01MB11865:EE_
x-ms-office365-filtering-correlation-id: 322810a7-1771-4038-e329-08dbb05614ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k9Vj96oWeBmNkOq9FYKpIhfmwTUXxl2Cgzr/h9l70YRUe9kEUjdpXHAxJP439UOi7SejS3CDQhJYu2KQrGHyWf+oL+x4zS6BWBMM3wkLUh4vy9Onfs37tBwkWICcW23GEjsD/3cH6IBMCl8HMSJ2SCGeCRqe9tYbRJ4Qxpgs/e/Yc7ShlXlHAiu35XUcRbWtGlbxeN8FIBia8FOQ67xg2sB3DY1FGOkKbcxQWRt9kE3d1mzwT+/FaSpdiVj86M8tjzHzy2UFfOvRuG4JZFoX3dbsyjE6aFjUpfnTYkZ1Qe91rXtp5JQCt8F/RJnPIClMDVFE4k8gH5MqjMytP0Cejef4MDbrHjTMWCEg5Dxa3O5t3aOkzXbJ2w9caUMj7by7SKM1jdJdD5WXtlvHCdJlKk1rszYGIcBq3SETrm3dRVOY+NYwmZHq1eqC2lA20zYjJ1xYPX7TA+0D29lmLSqWRziKDoer2MAbv3DEn4mgVfz5cuuEwaM5DXryqP4kbKFblfHUh2A23WIYGUTJAW562G5tTAsdMs3g2e1B80U7LgkomseIZmixV9wBauv8T19qxsBw6HDLA/hJ0p7Pg95Lo5c6RzwG3t2TNrZvvJ+AXywUNFg6vU+eaFgvczzh4b3csZAaCsk7AIe0xZLEIqtZmA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB5640.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(136003)(366004)(396003)(1800799009)(1590799021)(186009)(451199024)(122000001)(82960400001)(38100700002)(1580799018)(55016003)(224303003)(85182001)(86362001)(33656002)(38070700005)(478600001)(2906002)(110136005)(9686003)(71200400001)(6506007)(7696005)(8936002)(4326008)(5660300002)(66556008)(52536014)(54906003)(66946007)(76116006)(4744005)(316002)(66446008)(64756008)(41300700001)(66476007)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?Y0NHK09RYXFSMW9kOVE2WldDUmw0YkJIVmUyQ3lwZ3dHS0VLbmlKSnlXeHdi?=
 =?gb2312?B?dWQ5QnVtVDRwbHc5U24vQ3hpbnlnYUFNcVhUTm85Q2pscXd1SnpKZ1RKK2ty?=
 =?gb2312?B?ZTI5c0pVbnlqY3FzUlJFYThUdFlMSDR4THdPNHB5SUcvQ0dYVEpSV0Q2cXN3?=
 =?gb2312?B?bzh6Z1RvWGt6cWx6ODgyR0c1dE9QSi9jYlZobFRpWktTOEVqdlg2c0F2WVR2?=
 =?gb2312?B?NGxCK3R3QlcwZWtaT2hwTTlzTTAxc1ZQWWpCOHdGRXlZZHVyMHVCeXhKV2d4?=
 =?gb2312?B?RnYvaWdoK1ZPZmVZUk1ncDdqQnhGU2dRMjAyMEFFcldhR0puVHRUOU94bldS?=
 =?gb2312?B?UmZaY1R1c2h6aGJ6WGwyc2hIMW04azI5WTBteGpNRnE2TElkcWgyV0wwRnUr?=
 =?gb2312?B?ZFJMOGU3RXIwalNWTnIrb0NseHIydzgzYzRVMHJ4T0pneUdPbFhFNHp3ckNT?=
 =?gb2312?B?UklYSVF0MktWc01aVUxBS3JUZHFxNVZTVFFHUHlUeWpGSGtZTTNGaVdUdDFn?=
 =?gb2312?B?bC9DUmN2T2xaZ3dJeW1TMjJWaXVLVDhReWMxTUllUExPSTlVbkJxL2pYYzZ2?=
 =?gb2312?B?emJsandldkp1OEtCOFdMUFljVDJwbkIzWTYvWlBIRmlWemJwcTkyYUpNZVlH?=
 =?gb2312?B?Nk0zN3lLMVFJVm5DanhnaEJxY2lCZGVsMnZLN3AxR2pNb2I0R2RmelFHN0FV?=
 =?gb2312?B?UEUzWTZ4ZzVMNG1JNWgxM0JBeTQxcTJRRjB5dUNmWVRmNHJnWG9yQTlOYzA1?=
 =?gb2312?B?Yzg3bFJHV0tCRGYyL1M2N1RuL2hsNXVWQUdzQjI5N00xM0k2bm5WczFETmpB?=
 =?gb2312?B?bVc3cjFldWc2NXZRdklIUDVRUllTb3NZeFpUVDQ2eW5lTVQwQk5Qd3g1ak81?=
 =?gb2312?B?M1cvMzBvS0xRQjNvUmVHNGJGQ21oZEdIK00rQlhGYjdQMWpNSWVYMFRoMGd2?=
 =?gb2312?B?Zmg5Q2FENWRENFNOcEZmNExqaFgxZ1B6Y1UwUXFhc002R0o0UG1Wcm1aVHJU?=
 =?gb2312?B?R3VXNGVGSTNBdGczUTBRcjIzaVdoeXkrcjNQbnRWd0VKVEJBZjBBQmhGV3E3?=
 =?gb2312?B?YUJFL01QSWtYYmlRYzdQN0FIcFE5U3pkS295bWR2OU05ZGhma1pDbzVNWERi?=
 =?gb2312?B?MTNQcTRPc0dKQjFXVGVCYVVPS05QRklsRUVvMWo2dHErVkM5MlVvaVUrRXBB?=
 =?gb2312?B?S2JidXM3RCtqb001cTliek1KWDcvMWlmNlppckVkUFZtSU9DMTk2dTl0N216?=
 =?gb2312?B?OXV1Z0szbC83RnBCSlB4OElVYmhkVVM1MjRCY29mN2l4dXJzSE5sZTh6c0Q1?=
 =?gb2312?B?aXJBY0ZjUm52aVdMTUJQeWE1SXhIZ0JsVnJZNUxxdEJjNmhkVDY5ZjZxZmd5?=
 =?gb2312?B?emE3ejNsbHRhbWtUbTJPRHZYUjVDa1FUNHpSd3A4b2UrV3dIbzNRU0J3K2tt?=
 =?gb2312?B?SjJqa0E0S29LRlRyZ0FJSlBYOFpxN0JhL3dBWUZ3VWs3aGRURFJWUFc1UnhU?=
 =?gb2312?B?SVpOYkQxU1NnVjM4cEN0aGxKeTNqR0FsZ1VtN09BazdKSjFQUGFUR052dzAw?=
 =?gb2312?B?aHZSQUN6QXo1SWNpOEhsN28zcDlsUXBGb2JkazAwZEUvc0R5dGpIbmY1UWRt?=
 =?gb2312?B?Z2IxR2phM1lhYmo1bnF3MWhKTXZtSVh2OEttZ3REQzRIQ3RtZjd4bkl0YUY0?=
 =?gb2312?B?cWJMY1FncTZmR1NvVUZaWEYwVy9LcmRnVFZpeXFUNkQ0MG4ydFVpN2pDajky?=
 =?gb2312?B?VlpjTzdVeGpadWhBai9LL2xpdUYxS1NLWTBrRU4xMmR5bHRMWUppaXlsRzdP?=
 =?gb2312?B?RW8yU21GR0ZIdG5wMWZKZllTS043MUErMzVuNHdpbUFubWFvVWVtYXQ2eXg5?=
 =?gb2312?B?QXdscmlsUk9HL3lUNGowTWV0bUJkYXFiT2ZROHc3blNIUit3RXhNd3BZbEx2?=
 =?gb2312?B?am9wR3JnRkJ0ZEtxVWZCRG1xM1IwTE9yazF6TVA2d2JTckY1Y0VuYWZIMGFS?=
 =?gb2312?B?Ly82V2VGTDFHdXg4YVVEVnRPaXM3UFJTaEZHT0ZRb3BjOXV5RDZ6WkljRHRr?=
 =?gb2312?B?aENhdUdrK1JHUWx6RFB4cXdnWVRUN0UvTCtkNGg4ZEFFd045WHpCcVZabHdi?=
 =?gb2312?Q?sAxF4651Awfwaa56Fs1KgOgiv?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: YrpRx0Z+hSXlgIL4/z2bFqVV3xqP4NvCPzhqZcGdgfTAD9ycB8gWGDDUIypzIfzHQ5gpcaLtanZ0Cl6OF43NDC4/O1ASpVOxikRWJ0MRo/d4GBgokgoi8TC/Lj5qWHdsLbsTlWtAU5mTZuLQwclf0FeDDkR+2fWq0NVSyFXNXBNst3Z3XyxkA+Zu0qV8MTR46mEo2TbBC18pGTmC972MBxT+Kw5dqfeFkcssprfLNe3hdtYdCMypJDYmcdF5YoQ1ov8hqlIlUcF6lrovZJyRjnvOVKdfLpwgjcNj1Qc/0yl9T5w1m3xV/OSB5S9YkEZuCq+JYBuds/40D6HlPioES6MzjxFSk3K+7SzatkeWfSicnyiULAKf2UOzZKwuBT8+pFPNw8eMy47N16XDL6JV1XH7zFz3MvixYm9OxDycvhLUfnrMyWcWIlB5b7chleFYJjo4kPbGzW7YNfYmDt9MDAL546HGYnU7PzcOPACow/V8bZJFcWT2Mluuq8185Tni6DAXveDeed4KhRsRCMPT4+HWeRWhK9nX831FDJhUIZ0durplPT/KLhR1JbEieVZb8cEE7889jGjyvfB+WXx/wAjZW2jP2Qg84B3RH3zU/NOqi80DmhKgHOOhEKjhjmPxZnpiSx+HmnRLYKmnI2L9JIZpc0LkYSUMXou3Abt63FmglVUYAIyg76P4vO/VArbSV9jjw98ob011BMH+LWhr8Uiwx7NWMlSSyoh4B80j6KseSp0+PltD4CpcZndf295dwR66LvUphq2Pu9fR6FzVTspqrmLDMyqc+SA3crJCWFpQbqWNW3b58arjUiUSRpFqc//EzPDH/OjlVQGUHkhp5g==
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB5640.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 322810a7-1771-4038-e329-08dbb05614ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2023 10:26:35.9405
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fgB1M6dq2W48NP2LnRiWwO7uB0vNB6kzMArdxnGFe6DPBiL4NhB5/aygrkiy+GlSYDZlSObM/aYArUYLyJUktg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11865
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQoNCj4gLS0tLS3Tyrz+1K28/i0tLS0tDQo+ILeivP7IyzogQ2hlbiBIYW54aWFvIDxjaGVuaHgu
Zm5zdEBmdWppdHN1LmNvbT4NCj4gt6LLzcqxvOQ6IDIwMjPE6jnUwjHI1SAxNjozNA0KPiDK1bz+
yMs6IFRyb25kIE15a2xlYnVzdCA8dHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbT47IEFu
bmENCj4gU2NodW1ha2VyIDxhbm5hQGtlcm5lbC5vcmc+DQo+ILOty806IEplZmYgTGF5dG9uIDxq
bGF5dG9uQGtlcm5lbC5vcmc+OyBsaW51eC1uZnNAdmdlci5rZXJuZWwub3JnDQo+INb3zOI6IFtS
RkMgUEFUQ0ggdjJdIG5mc3Y0OiBBZGQgc3VwcG9ydCBmb3IgdGhlIGJpcnRoIHRpbWUgYXR0cmli
dXRlDQo+IA0KPiBuZnNkIGFscmVhZHkgc3VwcG9ydCBidGltZSBieSBjb21taXQgZTM3N2EzZTY5
OC4NCj4gDQo+IFRoaXMgcGF0Y2ggZW5hYmxlIG5mcyB0byByZXBvcnQgYnRpbWUgaW4gbmZzX2dl
dGF0dHIuDQo+IElmIHVuZGVybHlpbmcgZmlsZXN5c3RlbSBzdXBwb3J0cyAiYnRpbWUiIHRpbWVz
dGFtcCwgc3RhdHggd2lsbCByZXBvcnQgYnRpbWUgZm9yDQo+IFNUQVRYX0JUSU1FLg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogQ2hlbiBIYW54aWFvIDxjaGVuaHguZm5zdEBmdWppdHN1LmNvbT4NCj4g
DQo+IC0tLQ0KPiB2MS4xOg0KPiAJbWlub3IgZml4DQo+IHYyOg0KPiAJcHJvcGVybHkgc2V0IGNh
Y2hlIHZhbGlkaXR5DQo+IA0KDQpIaSwgVHJvbmQNCg0KCUFueSBjb21tZW50cz8NCg0KUmVnYXJk
cywNCi0gQ2hlbg0K
