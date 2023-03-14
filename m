Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0607A6B8896
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Mar 2023 03:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbjCNC2e (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 13 Mar 2023 22:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbjCNC23 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 13 Mar 2023 22:28:29 -0400
Received: from esa2.fujitsucc.c3s2.iphmx.com (esa2.fujitsucc.c3s2.iphmx.com [68.232.152.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E5C94A4C
        for <linux-nfs@vger.kernel.org>; Mon, 13 Mar 2023 19:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1678760899; x=1710296899;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=+9FI8VxmNdSdMH4rkqmrP1uohDYcGBTiTEqJwwsOvhU=;
  b=J3KbGn1U+2qWLeg7c1S31RTJ+8TkH/xBwrToALFrvvPP9v8PSsc82qDw
   sOkJ4DA0dL6EE/1vyXsbnayhGoE17HdK/TmOipGXQ7xnokbm/jb7uZtYO
   oFivmcEAQFsXfG3ed4tPhao8YTiN1BO1IfL1amYOpOv/QKJ7WGh+zCa9L
   JwCzbLl5KvIdrBY0NiEL6tP5ZiVg6ryU7CpRR7qCyleajEewLaeW+P8oh
   PPyl0YIrDefKgoP1gZr5mTbb6KXJP71KZB1v87yCKCXOn2FHzZ5CYYnJ7
   jte//+eY+IIR3iZ1uBbIF5YfMQzffRf5oZIq5k3PbxZhSth2lDtjjv/1I
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="87461920"
X-IronPort-AV: E=Sophos;i="5.98,258,1673881200"; 
   d="scan'208";a="87461920"
Received: from mail-tycjpn01lp2174.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.174])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 11:28:13 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zj81VqsGri9VNvvYLzxNwtIKEKUPRVOZxydqHTbAlIg+pdQGtaoMHY2P6eNF6zLsGep7J5yl7IWPuT8tzFpKKAKzo956/aIjU+G4Ia2lgD80AnwyF7XbRSl2xcJCvDFXi+/XYrx1I5zrx0qh+9sskrQMSprCkpWxQq3dxwKA7hj4skQicWow9kB6Rv2AmF2ntCoNHJ1+KjDVzHXxaM95rMX1G6VPEV4JI3+BUIK8fF1ymXoPjWoEvmq5MbZq7MjsYtebqmSCHIgqt8zaHQch7oZQ94+V+Mm7VRjwXgd3c/0sQHnLOFKGrXbc8DDBhBUmeLAQjy+W/kaLMGzKk/CvQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+9FI8VxmNdSdMH4rkqmrP1uohDYcGBTiTEqJwwsOvhU=;
 b=GmrhBYaSlyOA8GtCsKBD0SNZxcagYfapEPz30+Tlz0cm9ko16mcuE11GzeFo47E2mSGPx2Rv3UV0AV4MSno2/WACkFIZkhWvWZtJ9Gqj8IeSrlEkqiwhgesaiLPnHkfGSiHpGmVlz6Nk9jbaFSzF7HjiQSXOne6cR8rlKELtCfW6XGvevNZBsi8v348x8st08+VciJYQ584U7WzGjYsFGaics7qL48rQdP4xAvZyXpBxJ4P8BKKVcyFD10+5ss4wiRqXK3sWx/eT3GcJmBLbfnBfULgtczvLQeiGDkZq5HnN+PnHvcHBiaFwDkb6zA05VkqasVF2iAgtykNOs3hqrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSAPR01MB7183.jpnprd01.prod.outlook.com (2603:1096:604:144::12)
 by TYYPR01MB7784.jpnprd01.prod.outlook.com (2603:1096:400:115::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Tue, 14 Mar
 2023 02:28:10 +0000
Received: from OSAPR01MB7183.jpnprd01.prod.outlook.com
 ([fe80::d7f:a3c9:8f14:463]) by OSAPR01MB7183.jpnprd01.prod.outlook.com
 ([fe80::d7f:a3c9:8f14:463%3]) with mapi id 15.20.6178.024; Tue, 14 Mar 2023
 02:28:10 +0000
From:   "zhoujie2011@fujitsu.com" <zhoujie2011@fujitsu.com>
To:     mora <mora@netapp.com>
CC:     linux-nfs <linux-nfs@vger.kernel.org>
Subject: nfstest_delegation test can not stop
Thread-Topic: nfstest_delegation test can not stop
Thread-Index: AQHZVhyeEgfrYxW7RUGMwOMBUm8JrQ==
Date:   Tue, 14 Mar 2023 02:28:09 +0000
Message-ID: <d5ed9eec-4bf4-8d70-0960-a30b2ef03938@fujitsu.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSAPR01MB7183:EE_|TYYPR01MB7784:EE_
x-ms-office365-filtering-correlation-id: a31cff4f-1eea-4ee9-cccd-08db2433c0ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Wlzihq+CgfS19oAKhkkFDWm1YCQMKxCYjSoUwGF0eUURApXyuerYuliCYbH5jLjkCI72Bu24UPmHx6cKH134YCHDmwhxKBr3HZLDMyMthFz8xDRgWSA4llDzy3cVvBXd9iFqwDx4ew9lb5o9N6ZzOmtFLGqI2Lqjcm9knQOiZHhbXzsu94QnIdKfP8LH6A7RPt0XfkgzxSkUGWZ2gscG6ovJbuTAt9HGrLZHReJm8IzLhUrx6k/SsOmFqym2GTRSGAL+VW5GeRgg1gUC9xY3bMV6fOuwCqe83Ywvlq9HiDrM2JuqtOr1wHGZ5b7DtF0XLXkfDMXXm/mQGHd21rrd81/4vPXNcYS83g4jmxetup9fUX8Lc11eruE25YRyt1iENSUMPckTosB5vWagFC/YejBM2GqffKWu8JP1lNqJnhchE2y0+pQhZDU9EogPpVDU/EkYhEvm7AISAcG8+OrHgRPxbg8c0W7UO0MJnG3OZm5S2Kb61lz6/OKTQ9Ku6aBvtFcbcpD7gzA+wndO8pRrtoBlKRME/B2nmlviaEcT8j6EaGekvaDKM3Gfil8CcViqEvsqP842WBLdk4tZRYgnTTH9k10avJwZeqyAm0MBONMO74B9RIuFOgBI8bs1OiKqMjCLpmc8s7VaYX8TQz44gibWgSqP8aUArayUplSnPd9I/kBNqbW4GL6UuR9DHVN2Mjur8/5srxCnWJQNp5tSck5jq6fco7EQzcTEOVzu0t44OF8W87wuUNS1sPSB8woc/eS16IdVfxf2UNQ4Q9UE7A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB7183.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(396003)(39860400002)(346002)(136003)(376002)(1590799015)(451199018)(31686004)(1580799012)(85182001)(36756003)(478600001)(91956017)(316002)(76116006)(66556008)(66476007)(66446008)(64756008)(66946007)(41300700001)(8936002)(4326008)(6916009)(5660300002)(2906002)(38070700005)(31696002)(86362001)(8676002)(71200400001)(6486002)(26005)(82960400001)(6512007)(6506007)(186003)(2616005)(38100700002)(122000001)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RUsvZWEvTjJHREdnMFJqYm9MZkdYTncxem42T2k2YzRKZytGOGdNb3gyb0Vo?=
 =?utf-8?B?c2ZWcmV4c2RTMXR3bkJjU1VNS3BqQUJIMG1YSmx4UEFydlp6MjVLK245bXUw?=
 =?utf-8?B?Nlh2REJaTnRBNlNOTW5nb1pEekl5d3JzSjdpYUk2NTl5ZmZGTGUxMmJwcUds?=
 =?utf-8?B?K2V3OGRUU2UybmJKZ01DTVRBOTdOdzEwd2tDWnBPRUhid2NlREc2cmFtdHN5?=
 =?utf-8?B?NDJOSEVkQTNobWp5bHVhN3FtSThJb1BkMXNaY3Z4ZkVRWDZpWjZSb3V6bGJG?=
 =?utf-8?B?Qjl5WGNGU2RuUGV5SEhVbWMrK1FIcTgwVWtUTk5kM1lrSHJoaThxeC93SXBp?=
 =?utf-8?B?MzBFTzhUSW1lTkZpaHBWTUN6RzhOY2V0cmlnYXF2QUJ5bjRLNmxVSGh5RFdw?=
 =?utf-8?B?OU9rWlhjOHJKK09UMHhub3Z0YnlSTWJzRFNzdjNJUkgrYTArNHo5TVNLSHZ0?=
 =?utf-8?B?aDBTZGxUcDlSM3R6cCtYS1hwQzlkUlpua1BzWEZPNk84cFNqWmhNNHU1QU5P?=
 =?utf-8?B?ZEhUeVVuSEo4Tlp0Rlh5cFZicndBcjVXR2pOV0UwQTNYRzdZT2hmd04zdkgv?=
 =?utf-8?B?MXV2MFhkeW12UThWSE5xbzRwY1djTzIrVDdXNnhXN0NOYzREL3A0WjRzM1ZB?=
 =?utf-8?B?d2g1TjFrNkFEZ1JXdGhWRitlMks0eHhPNHp1ZG5oMTlCaG9wTXZXYUVxbnln?=
 =?utf-8?B?NmtCQUo2RlE5dlJzcHg2WCtLQXN3Z3hrdzVVY1U5ZXpuZzEwQzU3dmhQazlO?=
 =?utf-8?B?QU1BNkVzRjFxK0RYTXlDRFBSRyttVGFGK3dMb3c0cUNKNGxDNXAvejJ5elN6?=
 =?utf-8?B?eTlmdFB2c2gxQU5PZVpCZ0hpSXhPeXZKU2xzVmhZaXVXR0pRSThLTXYwZGlk?=
 =?utf-8?B?UmdQN3BwMTk4UExINTFjV2xnUjEzNzMrWXgwaG54eGV6NU9BVFdZbUlWYzYv?=
 =?utf-8?B?N25xOWRnRDBYc1dhQ0tpc01rSEE2Z2MxcUtEWWtqdkxocVZ0VklRYk9kYkt4?=
 =?utf-8?B?c3RwcG9SUU5YdGE0b3ZwaGxMMnZWQlU2Y2hRRDJSNWdsZkplMXpKR0RUOGl4?=
 =?utf-8?B?QmxhK0gwa1VibkN0WmU0OERFbU5ybWRveGhzMDJtbWJXckh5V3dGWjd5ZHdY?=
 =?utf-8?B?N2VheFF1UlJ6OGRXd3BIOWxMdUFhRlBNS2RRWDRwUVVxaXpkMVFianp2K2U5?=
 =?utf-8?B?OVpTbzZJcTJ3WWpuTFIxbjVXYWxsMWd6R0FwSzYyN09GNUtDZTloSmZoaC9X?=
 =?utf-8?B?QkdIemF1THh0MmZ4eVZBNEtpTzF2Smw3NElsc24zeHEzS1FpUVNFYjgwWkpv?=
 =?utf-8?B?WkFDOCtmeG8rUk5jQ0ZmN05ZdGtwaGxBRW5SNk5tUlhyQXpSN2NaelI2YW9z?=
 =?utf-8?B?VXkvKzJWTEVYWnB1ZHQzRGllVDlnTHhxVmh6ZTdOMzVzYWVJcm9xUVlYUVV3?=
 =?utf-8?B?dVMycjNFMWVpQVJ0MFFoSlNTeXRtWGoxM3pHZ1BGRS9YOEd3WkI0d3FRdGRO?=
 =?utf-8?B?UThzL3c2VWJmeGlZcGtOWmZFbm5jc29seDVMVlZDUk41WllZak92WjdCTU04?=
 =?utf-8?B?UE1TNE1lUnhCRmNDemhNdDJ1OUhhZEc1WnNYMnA4alB5TTRIczFzdzBNdkxy?=
 =?utf-8?B?VU9QZnlrNEdSMHpuZzZVb1RLL1ptM2FISkZPdE9JdE85aUdSQzAzK3VmUkJl?=
 =?utf-8?B?MGxVQzJ6V0RqY0YzZXVCeUp4QzhHNjdVTzBKTThsM1BQNlhVa0lYRS9aOVRT?=
 =?utf-8?B?dVd0TVc4QlRmeHl3WEhQYlF5RVljeDhWbmFEMzk5NStKRTVjcno2dFRqK1hJ?=
 =?utf-8?B?NWhuMmlSL0FuOGtBYkZ1M282WGEzTjJQSHBFMFdUdndZdlZZYjNQTHlUUEIz?=
 =?utf-8?B?NisvajltR2ZKZmtPVVFsMVlvL2ZhanEzQ3VaQjFnSW40U3dqdWI4aGpOd09F?=
 =?utf-8?B?U25rMGw1S1pRN3hKUTV2cCsxazlZSkRudmpGSm0zeStDTTVydmdyT3cvd254?=
 =?utf-8?B?Yi9sZnptemJQcWl1UVQzYW1EVmtXcUFyRzFDU1kzcVc1THNteXRRNFE3UzdS?=
 =?utf-8?B?Qy8rcTdoc2J6RGloK1owL0dIWkt4dHVzeHgzQ2JheHJWRys1UGVkQy9LQVli?=
 =?utf-8?B?dDRDWk1LbGZBQng3WUJhZndxUFB2Tmc5V3FUNUZ3dGgxZGVjU05lU3ExSStT?=
 =?utf-8?B?Wmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F1C740506D30A44D972E31095CD006D9@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Ux4ZOm1GigaTkMoNJ8iO4ri1Cb3rQHV8S4pwosS4gL/ERXbbqP0XkDcHuoTugr2pXLOMUySBFNAwXSnzdVbtv+JaTLusa87WxNvxg9sOhqMefJOWxI3hvkMU+ozonxNbr9xhdQSBX6Q5hVzVfOJt4JYV2EosstE42c1Gh5yQgCb5At5f5r/j3Qe9phY2Tsev2sY5fLar8TsQIfSaBPCfSm2lkh3M/gADbZbO2f2+8V8gCX+70xX4uOJ5WhVLC7fCetqkFwMk+j23hLOy0q5bl9zpR9zsnOZTbWnkembE9mqLvM8zzagtOJXBbVLEkJ43TVz7pN52NFg8kwx8UVRoZNLMun06ni1Bs3eAm4T+mkFkKKhvnFoUtvdJeRnixt4rVDtsihSgQZ7UN9cl4ur58tdFlpbTOfubbco/yyQS6tmiIPlLky7qWcZRv4Xpgm+DUv2e1/dcBxwvoAVy+gbd94kuJn1o8fAPpe1FOgLO9IzGVixtracpc8R1VXO21NX+lYGSuhMCBJJCqq9DLA00K4onUSG6ulcp5U7598pX/rkYX8H05xzkZXkjG8m98qH8dAMpFTjZ2cyMjWBm2mv40uXs0aDTL9EI2PKLwFFH1g+RdNKmFN/NnJz+VfDjZpuo6EllKu4ZHZlcUzVc3YPYewczpi81a/pLsEPZF0FfeS0UbTq+4iDo2cBAH4vIvcabBesOQub1SmTTnTs191d39B9XD8ILtxT3NIhkG8cycbxYYaSXVJyAM2TG+djdQl4Mos2t3TlEPgC5T/a1rWASyfaShPwlJMDrQh6vyk2uw+c=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB7183.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a31cff4f-1eea-4ee9-cccd-08db2433c0ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2023 02:28:10.1133
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m2SDrslWucVa56omEId5AKD8dxUifVUEnUPQq1ix68HaMCg/ATMWxrnvo14/fGXffpXTCSal9RtM3beLQZQ/VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB7784
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

aGksDQoNCkkgcnVuIGZvbGxvd2luZyB0ZXN0IGNvbW1hbmQgYW5kIHN0dWNrIGF0IHJlY2FsbDEy
IHJlY2FsbDE0IHJlY2FsbDIwIA0KcmVjYWxsMjIgcmVjYWxsNDAgcmVjYWxsNDIgcmVjYWxsNDgg
cmVjYWxsNTAuDQoNCi4vbmZzdGVzdF9kZWxlZ2F0aW9uIC0tbmZzdmVyc2lvbj00IC1lIC9uZnNy
b290IC0tc2VydmVyIDxzZXJ2ZXIgaXA+IA0KLS1jbGllbnQgPGNsaWVudDIgaXA+IC0tdHJjZGVs
YXkgMTANCi4vbmZzdGVzdF9kZWxlZ2F0aW9uIC0tbmZzdmVyc2lvbj00LjEgLWUgL25mc3Jvb3Qg
LS1zZXJ2ZXIgIDxzZXJ2ZXIgaXA+IA0KLS1jbGllbnQgPGNsaWVudDIgaXA+IC0tdHJjZGVsYXkg
MTANCi4vbmZzdGVzdF9kZWxlZ2F0aW9uIC0tbmZzdmVyc2lvbj00LjIgLWUgL25mc3Jvb3QgLS1z
ZXJ2ZXIgIDxzZXJ2ZXIgaXA+IA0KLS1jbGllbnQgPGNsaWVudDIgaXA+IC0tdHJjZGVsYXkgMTAN
Cg0KcmVjYWxsMTIgcmVjYWxsMTQgcmVjYWxsMjAgcmVjYWxsMjIgcmVjYWxsNDAgcmVjYWxsNDIg
cmVjYWxsNDggcmVjYWxsNTAgDQp0ZXN0cyB3cml0ZSBmaWxlcyBhZnRlciByZW1vdmUuDQpBZnRl
ciBjb21tZW50IG91dCBhYm92ZSB0ZXN0Y2FzZXMgcmVzdWx0IGlzOg0KNjQ2IHRlc3RzICg1ODgg
cGFzc2VkLCA1OCBmYWlsZWQpDQpGQUlMOiBXUklURSBkZWxlZ2F0aW9uIHNob3VsZCBiZSBncmFu
dGVkDQoNCnJ1biAuL25mc3Rlc3RfZGlvIGhhdmUgZm9sbG93aW5nIG1lc3NhZ2VzLg0KSU5GTzog
MTY6MTk6NTEuNDU1MjIyIC0gV1JJVEUgZGVsZWdhdGlvbnMgYXJlIG5vdCBhdmFpbGFibGUgLS0g
c2tpcHBpbmcgDQp0ZXN0cyBleHBlY3Rpbmcgd3JpdGUgZGVsZWdhdGlvbnMNCg0KdGVzdCBPUzog
UkhFTDkuMiBOaWdodGx5IEJ1aWxkDQpXaHkgZG8gdGhlc2UgdGVzdGNhc2VzIGNhbiBub3Qgc3Rv
cD8NCg0KYmVzdCByZWdhcmRzLA0KLS0gDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0NCnpob3VqaWUNCkRlcHQgMQ0KTm8uIDYgV2Vuemh1IFJvYWQsDQpO
YW5qaW5nLCAyMTAwMTIsIENoaW5hDQpURUzvvJorODYrMjUtODY2MzA1NjYtODUwOA0KRlVKSVRT
VSBJTlRFUk5BTO+8mjc5OTgtODUwOA0KRS1NYWls77yaemhvdWppZTIwMTFAZnVqaXRzdS5jb20N
Ci0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ==
