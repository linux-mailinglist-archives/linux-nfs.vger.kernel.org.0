Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA2A6779AA
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Jan 2023 11:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjAWK6C (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Jan 2023 05:58:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjAWK6B (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Jan 2023 05:58:01 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D23CA10;
        Mon, 23 Jan 2023 02:57:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=auo4dLCBzY8Poq6mcGGWyM5FfIxjR10O+5gBlY7OA79g2K9nNlD7ov/SbouesXqhWqglYaa0/f06JN9mV9ybzkB97UvgyMc7lOM2XTPFkVJXrV9JHDj3+7Dpx1txD9V4lgjtPJ/hhE5maJ60i5OyhFcomsJUVrNY5X0T474Y1jZ/mqqQIHr3V27upozeJfKhBwYughQ6g3Qi63nEgAbI4Bw0fpi1Fp1DTVMHB0A5avqWnx9SioGN3QREYFhwZ1w64+G+CYDtF0Je96D4+4/8uf3FPaZVaXlvbXaZ0vmSfUBiaT0yeJaYR82RDTkB6JTnKOhyfwxzv6RtGcxnZvTr8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uvcia3w3LO8HAlajKfCWEdbB3jiWCbftGFlGoUJStG8=;
 b=FBbZ6BGhF5rbH1TnnPlvgJBkZxa/5m40v0vuIFPzyijoksuPFPuxQQs1PPUw3zul7it2VK5SsaTNB0hBItWNFWrruj6N7Tqkr/pLEVn8np4Wr8g6bmm+3SmyG1jLfQ3S4okczhCIXATeD08i4l4B2YrE0zmPc7/uiQrWbORRVLtQfib7Oq2JY8MWUqzFOYMkc6qeEXBhzaGd5vzitO0coQqhsnIOHe9OcCc/jYLjalsLErJPJ/YyPg1kPUhgzQfZ3X3Elf/WCyMtfy3rgBd+fndYP1mzeAy8YdYXdNA0sOq0JjrQOnN4knCR6TNSfWwC61CKDL0n81nk+phPU69uBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uvcia3w3LO8HAlajKfCWEdbB3jiWCbftGFlGoUJStG8=;
 b=P7hslebw1oInU1tJyYi0V+dS7PpGFFEX+reIMuEm5ZD1QOTA425LNZAiWI1Q5gGT3jFTvfFA2KFrMBYAjdGcBOLT5eX8r6vV+8NxjU3MUSsOHs4EcV2FsRqm2pOUdKjjGrtjQfCKv8zJv2yFciH/5IlD0TE9fj6XsypA6aWKM+GTNxUUXDe9LoVqV76/P+i6G5li36j+oAUw+YI6FFwc1HLQ2vDulObYUYiCWZywsBD8bk3DVcWz41A4TqDtLgCT9lEPoSwpmBd+o7QgHujSgM7de/PCWJ8ZpvJ1YrMKRFqwrNerfaipX1eJnSUY3U0n1waKKE30IHs/zzC1LJRXVw==
Received: from MN2PR12MB4486.namprd12.prod.outlook.com (2603:10b6:208:263::23)
 by CY5PR12MB6646.namprd12.prod.outlook.com (2603:10b6:930:41::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Mon, 23 Jan
 2023 10:57:56 +0000
Received: from MN2PR12MB4486.namprd12.prod.outlook.com
 ([fe80::70b:9b93:5fd9:96d5]) by MN2PR12MB4486.namprd12.prod.outlook.com
 ([fe80::70b:9b93:5fd9:96d5%9]) with mapi id 15.20.6002.033; Mon, 23 Jan 2023
 10:57:55 +0000
From:   Shachar Kagan <skagan@nvidia.com>
To:     Chuck Lever III <chuck.lever@oracle.com>
CC:     Jeff Layton <jlayton@kernel.org>,
        Ruben Vestergaard <rubenv@drcmr.dk>,
        Torkil Svensgaard <torkil@drcmr.dk>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] nfsd: don't free files unconditionally in
 __nfsd_file_cache_purge
Thread-Topic: [PATCH] nfsd: don't free files unconditionally in
 __nfsd_file_cache_purge
Thread-Index: AQHZLQi1Ys7+/1QvvU6pGCpXcVFjk66nv28AgAAJSgCAAVH1AIAABJoAgAFp8iCAAJKBgIAAvQNg
Date:   Mon, 23 Jan 2023 10:57:55 +0000
Message-ID: <MN2PR12MB44865F3CA7F74F93920B9DFFB9C89@MN2PR12MB4486.namprd12.prod.outlook.com>
References: <20230120195215.42243-1-jlayton@kernel.org>
 <C04F7C2C-848A-47C5-9C4E-9B9E5E82BAFF@oracle.com>
 <d5dc64435fb82f17e79ae20a370e90914a291ea9.camel@kernel.org>
 <3BB57727-27FC-4294-A5F8-FBD8E900D94D@oracle.com>
 <539c19a01e7f6d582d7ae2804977ef779b29d44b.camel@kernel.org>
 <MN2PR12MB4486882D01C0068FFAF9C841B9CB9@MN2PR12MB4486.namprd12.prod.outlook.com>
 <376AEBC5-AC52-424C-9DD0-A70BA73E7FE9@oracle.com>
In-Reply-To: <376AEBC5-AC52-424C-9DD0-A70BA73E7FE9@oracle.com>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR12MB4486:EE_|CY5PR12MB6646:EE_
x-ms-office365-filtering-correlation-id: 7ba6e29e-e7c1-4113-cc52-08dafd30aece
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EyH+ZsRWHs43c+J3FttvMUXg0VLD2yMJwFEu6OPt8Ym85k+quoF7pLPOhiw96R1LUoXgEutrn2ekiS4lKdXf/W3lkxCwjYfhnNJw7dimzlAiTGoHxzPItMi89pAv9va7/eahppHRGcslZ3jNwfFPgFbxmZDW7Wi6tTdm8GpmKXnM6DZTwNxx85Nyp3fVwsifdu3QU+kHgGbf7N/rJevc9+OR223cSK3xJrCafOFP4refLhld9Jw2jMhLPqOSRSnaF2sYtLqyNrGp+6KiIMWlSp04rQvb0k9b+WsauKFnjqOP1h8AscuF5Rj4azIyVGUn5fuorxioDl2M7cqiXmqbhYpiQKETL93Qup8ePSq8SxLHgdFLD8NisIkMojcsu/iMmGQpt8r0ReAwuGXM2T+KLTA+OFuy10GPXY6feK9q1CC32jU+Lz0qkhtg1/fZfF7RTMumFicJ0y5e/bDPDe6wVFZRmyelcW917E5oKMABP23oOWHH7fqYpOizWWsr3d/LryG8+X7Hp8d3cgPpklQh6SwnoHNsQ6Bij4iqxF3TKvvhzzw2FWCLMJjtxpywbXzO7+Zdnhi/KMweh4He0BXR0zILSQOApLHuvHiUUlOSOfIa2gdJ/bQjHnYv76YvEr9OKH4wPIyBnOCK++bxToux9Gjc73/0fN07LtqOoBc4VsvfSNP3oZkwzDD7Y8zes7+H2nCGz1dQ0omphQmLlmAdXg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(136003)(39860400002)(396003)(346002)(451199015)(52536014)(8936002)(9686003)(76116006)(7696005)(55016003)(33656002)(83380400001)(38070700005)(41300700001)(71200400001)(66476007)(64756008)(66556008)(4326008)(6916009)(66446008)(122000001)(66946007)(8676002)(38100700002)(478600001)(86362001)(2906002)(316002)(54906003)(6506007)(53546011)(5660300002)(26005)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a2EzZDIrZUlKQVJINDU1TFdhaGczRkxZb0V2cXlBamJkaEhBd2E4QjNXS1Jn?=
 =?utf-8?B?REQ3SmdKRXJpS0NFVWNNbFVmMGhyM1hTaUViR3R4YnN3YzdLeE9HOXBkcjVM?=
 =?utf-8?B?K1VrYkFiNVpsNWh0ZzVQbUVIaXJLRWFnMXpxa0JnOUd1T2NRQWdlUEMwdS9Z?=
 =?utf-8?B?RGg1Z3o2L0RnZFhlQ21NNTN5Y1RHSEJIUDN1blFKeGtrYng1alVqUndsMjI4?=
 =?utf-8?B?ZCtFK0prUUFJRmVTdHQwUHdzc0dSbHFrdzBHYWRnTlNsOW5iemIxSjlUcWd3?=
 =?utf-8?B?eFl3SEgzQW5EdXVYNEs5bFRHRGswdkIwMUh4bnVEc0dpcnFtaGl5T0h2Mm1L?=
 =?utf-8?B?SzIwYjN3a1YzaGJjTFplN0FET0hsZHZuVkdQSFdNeHlMaW16OHdQdjNTWHNC?=
 =?utf-8?B?bjFNM0xQU1FScXZsc245MklheWJpdHVZWFZ5VFIwZDVHL3EvZDFsUWNiRUZR?=
 =?utf-8?B?Uk83M2Z5UjhSeklxOGh3R1pkMlZIWlhZcFc2bExFWUxZeDQwMXkySVREZDhO?=
 =?utf-8?B?eXJMaVdOY3lFUUlCOVNveXRBbEhrVWJuSUFJREdsa0E5YWU3TXdDZ3R5RHJp?=
 =?utf-8?B?VXdBWEthMUZ5eks0V2J5K1c1U1NCY3lTVTA5bkswZXo3bk9FaFAyVXorTGd5?=
 =?utf-8?B?RXorZEJDSHdQZ2lTalRmVGVmQm9LQVdCSXM2akhEc0NOQkJ3amJxR2xYaEhz?=
 =?utf-8?B?K3VTUEJkY25ZZlJuQWJGdDA4bXBkMWVpRXhwZ0FnZE11aDZtMmU0VlN2Z1pB?=
 =?utf-8?B?ZDRHWGlNUFJlankyR29HTnVtWWw2THl1bTVsUXdwY2Flc2VBbVVCdFVodEVL?=
 =?utf-8?B?dVF3SVNZUDU2cksyZENVaDZxdkxxb1RIa2FmNlRUWFd1K0RqNjFmc3JPZzU5?=
 =?utf-8?B?NFRqRmdLQTVQSUdqNUo1cGh3Lzl1Z1lCZmQ5bFMzRGNmRGg1NXNIWTBxakVU?=
 =?utf-8?B?Y2hQaFNYN2hDV3hBaHkwZVg5VGFQSkdqWGFPanV5YTZFUHlnRGxOclVka0cy?=
 =?utf-8?B?NjFZUzlWNXlnbVJ0bEt3Q1ZwamR0VVNJeEt2d1B2aDVGMDJQWGlhWHVicUIv?=
 =?utf-8?B?WmttTThXUThDK3NqUXdLejVQcGJRQkUwOVE1L3FlSnhZU3VzWE5PbFhJQWdK?=
 =?utf-8?B?V0dpTlpsc0R0aHhEd1B2M0E0VXlvY0Nka0xnNnE2cjJBRCt0MytqSkZyZU96?=
 =?utf-8?B?QlJzVFRkUHFmcEZPZ3d0S3liM2daMk5uT2VNdjk5NVV6U3V5bUEzYnFnejJ3?=
 =?utf-8?B?TlBkSjFpNC85ZlkyNE1YQVA3dzNxbUpOTHdRa3pJeDd2VzFwaitoQ0NxeXB0?=
 =?utf-8?B?UC96cDNIWW9NT3RmbWhuMDBkVllzM1o4eFBYbVNQcllsQ1BxQXFhSVNqdmpY?=
 =?utf-8?B?d2ZwQnMzdFI5bzNoVDBYRWM2dUlyVU9GRGgxM0JqbXN3Z3NiSkJiTklueGZD?=
 =?utf-8?B?Vmx0Tk1iN2d6RVhac0liYnBKdEdSdFpBa3NlY2xKaDhmeXlyTEhHTWRXZFZk?=
 =?utf-8?B?ZkdUc3pZeW9HbzhNZGs4V3J5VUJwOXgxN0xsSDdPajIzSUx0NVJaaEpVdkdZ?=
 =?utf-8?B?VE8vaW5IdFRlb3Ric0JxSFZ2ek1oWWxRakVOOEcvMmJrT2JBOWFUa0phZkNW?=
 =?utf-8?B?WDBKa09zSjNCZkdkbnVTV2Z1VW5FSGJFQ0JVdDNwcm5WcnhTdDc0NTdhNWFw?=
 =?utf-8?B?V0FYU1kydWFkd2xCMDlLWXNtT1N5MzZrQ2cvYmx0Yms2eEVHaCtSVTc2OFJP?=
 =?utf-8?B?NlFodkVtSEF2ZlJ0WXZsb0tRTnY3TzcySE5HRm9mVnkyd2xmMlBxLzRaRFZ0?=
 =?utf-8?B?TzlJV2hybTlxVDBweGRZZ05DY1dWMnlmSWdtclY3M09nQVZuNXFka1hKOU53?=
 =?utf-8?B?US9QVVNZZXI3Q0RrOGY3YjJkVkMyNGpBMmQ1UkY4Q3ozdHBocnlqY2RSYmtt?=
 =?utf-8?B?UExjYTQ0Z3BDdUpKanZodEVQMDM4UlN5SUJaRDdzWVdTQUJHQnVzdGZNSXFN?=
 =?utf-8?B?RWZ3azlVVWMwM3lBNVJNSzBxcVpweXZLNnA1SjJhM292SGJrT2t0OTdLeWdS?=
 =?utf-8?B?b2l0TFVjdUpLaVlTOTdqck45amlLVkVIZERWZFp6T0VJLzBqY1haYStJWmhx?=
 =?utf-8?Q?RsfMkTIHHhUkmfz60moKunTcx?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ba6e29e-e7c1-4113-cc52-08dafd30aece
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2023 10:57:55.8923
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zxppPbDHuBNHwMBhuq4DWe9zkdL3pKedENkWbEAkUGQckIbrHwfV2owOiDDlam8QZxP5YL2si1kUDmb2+3QiRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6646
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQo+PiBPbiBKYW4gMjIsIDIwMjMsIGF0IDk6NTggQU0sIFNoYWNoYXIgS2FnYW4gPHNrYWdhbkBu
dmlkaWEuY29tPiB3cm90ZToNCj4+DQo+Pj4gT24gU2F0LCAyMDIzLTAxLTIxIGF0IDE3OjA0ICsw
MDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6DQo+Pj4+DQo+Pj4+PiBPbiBKYW4gMjAsIDIwMjMs
IGF0IDM6NTQgUE0sIEplZmYgTGF5dG9uIDxqbGF5dG9uQGtlcm5lbC5vcmc+IHdyb3RlOg0KPj4+
Pj4NCj4+Pj4+IE9uIEZyaSwgMjAyMy0wMS0yMCBhdCAyMDoyMSArMDAwMCwgQ2h1Y2sgTGV2ZXIg
SUlJIHdyb3RlOg0KPj4+Pj4+DQo+Pj4+Pj4+IE9uIEphbiAyMCwgMjAyMywgYXQgMjo1MiBQTSwg
SmVmZiBMYXl0b24gPGpsYXl0b25Aa2VybmVsLm9yZz4gd3JvdGU6DQo+Pj4+Pj4+DQo+Pj4+Pj4+
IG5mc2RfZmlsZV9jYWNoZV9wdXJnZSBpcyBjYWxsZWQgd2hlbiB0aGUgc2VydmVyIGlzIHNodXR0
aW5nIGRvd24sIA0KPj4+Pj4+PiBpbiB3aGljaCBjYXNlLCB0ZWFyaW5nIHRoaW5ncyBkb3duIGlz
IGdlbmVyYWxseSBmaW5lLCBidXQgaXQgYWxzbyANCj4+Pj4+Pj4gZ2V0cyBjYWxsZWQgd2hlbiB0
aGUgZXhwb3J0cyBjYWNoZSBpcyBmbHVzaGVkLg0KPj4+Pj4+DQo+Pj4+Pj4gWWVhaC4uLiBjYWNo
ZSBmbHVzaCBpcyBwcm9iYWJseSB0aGUgY2FzZSB3ZSd2ZSBiZWVuIG1pc3NpbmcuDQo+Pj4+Pj4N
Cj4+Pj4+Pg0KPj4+Pj4+PiBJbnN0ZWFkIG9mIHdhbGtpbmcgdGhlIGNhY2hlIGFuZCBmcmVlaW5n
IGV2ZXJ5dGhpbmcgDQo+Pj4+Pj4+IHVuY29uZGl0aW9uYWxseSwgaGFuZGxlIGl0IHRoZSBzYW1l
IGFzIHdoZW4gd2UgaGF2ZSBhIG5vdGlmaWNhdGlvbiBvZiBjb25mbGljdGluZyBhY2Nlc3MuDQo+
Pj4+Pj4+DQo+Pj4+Pj4+IEZpeGVzOiBhYzNhMjU4NWYwMTggKCJuZnNkOiByZXdvcmsgcmVmY291
bnRpbmcgaW4gZmlsZWNhY2hlIikNCj4+Pj4+Pj4gUmVwb3J0ZWQtYnk6IFJ1YmVuIFZlc3Rlcmdh
YXJkIDxydWJlbnZAZHJjbXIuZGs+DQo+Pj4+Pj4+IFJlcG9ydGVkLWJ5OiBUb3JraWwgU3ZlbnNn
YWFyZCA8dG9ya2lsQGRyY21yLmRrPg0KPj4+Pj4+PiBSZXBvcnRlZC1ieTogU2hhY2hhciBLYWdh
biA8c2thZ2FuQG52aWRpYS5jb20+DQo+Pj4+Pj4+IFNpZ25lZC1vZmYtYnk6IEplZmYgTGF5dG9u
IDxqbGF5dG9uQGtlcm5lbC5vcmc+DQo+Pg0KPj4gSSByYW4gb3VyIHRlc3RzIHdpdGggdGhlIGNv
bW1pdCwgdGhlIGlzc3VlIGRpZG4ndCBvY2N1ci4NCj4+IFRoYW5rcyBmb3IgdGhlIHF1aWNrIHJl
c3BvbnNlLg0KPg0KPiBNYXkgSSBhZGQgVGVzdGVkLWJ5OiBTaGFjaGFyIEthZ2FuIDxza2FnYW5A
bnZpZGlhLmNvbT4gPw0KPg0KDQpZZXMNCg0KPiAtLQ0KPiBDaHVjayBMZXZlcg0KDQotLQ0KU2hh
Y2hhciBLYWdhbg0KDQoNCg==
