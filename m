Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1C24BD317
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Feb 2022 02:25:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbiBUBUE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 20 Feb 2022 20:20:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiBUBUD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 20 Feb 2022 20:20:03 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65424474F
        for <linux-nfs@vger.kernel.org>; Sun, 20 Feb 2022 17:19:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JKbxTIdGNNDDpBtn+vIZL6fY/G3wxSCxklwdUk9l+JlquC+2gLo8S9dz9xGGCx114vFKH2SezGRDqgh3/u5TlrIKWU+DsVkuclpXc+7gS1zQ67Kxw87JrM3Zitu0zpCVFYyzJIim0o0l03W/mbxHr2sYT7dHkpemYvOaPKm7S4G6v4246SsKlQe75I0TPmZhxSsDuOfL1cfPgJLHDHXS6zlrnTGqZQta63ckbbcbyENLcCJqKnuXsVUnnrbFc/3Gm2rWa54qqBmcbStXEn47n0OnVIx83IZNIAi+hCbXMMaQCRx8dYyh0oeO68QKZikd8a5pJ6Ei5B2FVlR7fxwOzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EKmGG1LctkN74cjuosn/HWzkzH0R7zkNsArPf6Sslck=;
 b=hI9kE4jwjz+CPWvk5P9rS8hdVMy8Dpyi1Ec1ssGGyxKdNcyF7F1Bd+76MRHxIgtJfyIAOXil5keP96HVvVeOIDICFAXFVGvqognXfrMiSsbtw+JFxOiOOfItgiW+dSCZYMzIbltZa5ySwKFZ36HGH1XU5c0XcEMpLZlHpPka/Um1ocXJ6vaKaekaEzGPBXwkOK0taynQtFIN2IO6U2MA6x74fG1O+uOiyCxq+//ha44bmhEVW5kK9J7otUnLseuK1BBrbV6Eo5DJ9X8HMg4b0MlDsD0BmwTCf2JK4cTye2EbastxJz7uuRHhGN5X0Qvc1GFHxDBv8bz9evAdR9yMwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netapp.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EKmGG1LctkN74cjuosn/HWzkzH0R7zkNsArPf6Sslck=;
 b=spm7ru53gZyhCwx8DNcjsjBQ+LEFuGCi4UR2a8/kFZpmSLUVEBGbaXg6MCb0ZIeoxikZ56fzWkcLsVYekj5gaXRt6dHkHL9E3+r1PcPStPEMkOXCFGiT6GsAtJJ9YUZBMO6YX0/PVVBSe9IS+cqurdT6i0FPBabsnBdgXe6hxRpVWWNGLKLin+uGqfR9Nauvlf0T4rixMDKDMppuYqSchkh38p1ZbQCMkIygFN72QLzXpDaOYX0VnA4i886hgtBpfn7qwkbUnxocZpGMxxmamFDiggXLx2OC+04ZW2p9azcngwCCDEINUe/TwhE6uF32n98EnHybeY9M5VnO0/BlCg==
Received: from BYAPR06MB4072.namprd06.prod.outlook.com (2603:10b6:a02:8e::31)
 by MWHPR06MB2928.namprd06.prod.outlook.com (2603:10b6:300:124::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Mon, 21 Feb
 2022 01:19:35 +0000
Received: from BYAPR06MB4072.namprd06.prod.outlook.com
 ([fe80::8122:eed9:12e2:e6be]) by BYAPR06MB4072.namprd06.prod.outlook.com
 ([fe80::8122:eed9:12e2:e6be%4]) with mapi id 15.20.4995.027; Mon, 21 Feb 2022
 01:19:35 +0000
From:   "Kornievskaia, Olga" <Olga.Kornievskaia@netapp.com>
To:     Kurt Garloff <kurt@garloff.de>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "Schumaker, Anna" <Anna.Schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: Re: 6f283634 / 1976b2b3 breaks NFS (QNAP/Linux kNFSD)
Thread-Topic: 6f283634 / 1976b2b3 breaks NFS (QNAP/Linux kNFSD)
Thread-Index: AQHYJqjyA9hozeQrskipKHBWfsdUZaydEscA///OQAA=
Date:   Mon, 21 Feb 2022 01:19:35 +0000
Message-ID: <F693AC98-DCB4-4086-AC19-EE1B71DB2551@netapp.com>
References: <50bd4b4d-3730-4048-fcce-6c79dfe70acf@garloff.de>
 <8957291b-ecd1-931e-5d0c-7ef20c401e5d@garloff.de>
In-Reply-To: <8957291b-ecd1-931e-5d0c-7ef20c401e5d@garloff.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.57.22011101
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=netapp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3beea42a-ef4d-4e1d-93a9-08d9f4d838be
x-ms-traffictypediagnostic: MWHPR06MB2928:EE_
x-microsoft-antispam-prvs: <MWHPR06MB2928F312FD45EB7BAD5E527C933A9@MWHPR06MB2928.namprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zb5L/MDYPbS1760/qt3gFLHpFh12E1juxBmV+jgxbVVoZNvO0MZNm2SFsNIMhs9vPLU3NRjQYFyu1QLgNtzL+BB+ZsFuQTT6j9NX94DQbvNbvGYFNE0XmEs3V8VroTxal+4ECeMfhm1HM0EutXLJ903B/emqqs6SstWTwUMWgrFmwPds49laEqEBdpB/3Xy3J5F4mU58/6mJyOvDopph4M2y5WDA2OXju5rltGkWGPvh6FvpvFh+8iNlBR7k6gvo7cAgF3eeSL6OVeMXrmLMEr4m6dpIWfjSqkCRbZpg1M6+DsiT8I2SxTBB4iMUHI419DbROYNuQ9C13VKZ3j8OpecPYscsKvwqooin0SvHpVbVGrIdCovqTDYft0IaVMpurB8ZZKU2i27Gmck8AldydPVDTiYwhPqdI79B+NWSBNBvihwRQt5UR/t0tHlXWA1+vWNxl/NwukEe2rutvyfxFT+zg7FlIlYfQ8N6TGu78ga8hTVtrcDx/Q56uq2yeQuyymeIuwqna6QD0GSxJUaqGV/JstKXj6VlSBbNB3ySCT/Qzd+NheNOYftKv0XjNV2H54jnx5IDCYkK4WqDcuORskmwCOvl5rIew72+706AV4ED4RzFYiQ/lw6hB5dYLdnVd2TrNtu6ohWoq220wgkFGa9nx7FvzEmJpFJsXZnvBDRN2m7pdBCi8YHeOBPDnAYERDwGQ1lJgC7A7Op/ikp7ULIXhWdpCjgbULabUVHQdUSRHkAv5ucyR5T2uabCSYld
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB4072.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66556008)(4326008)(91956017)(66446008)(76116006)(8676002)(66476007)(6486002)(66946007)(64756008)(508600001)(54906003)(6916009)(316002)(33656002)(83380400001)(6512007)(8936002)(5660300002)(2616005)(2906002)(38070700005)(122000001)(71200400001)(6506007)(86362001)(186003)(53546011)(38100700002)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Yzd3bDF5VUxhV3huUWxuWHQ3OGNNSWhOaFhZd1p1T0lxZ2pSNWEyRXRtTm5n?=
 =?utf-8?B?a3h2T1dxYnIwb3dqS3A0bGhFQi96TmF2MHJLd3czaUxCN05aZnJWR3hhSW4r?=
 =?utf-8?B?cDIvazdhbTBVYVcyZDB4ZFByZVc0dVNkRmY5N05lcWpLaXJ1RG05WDFQSC9s?=
 =?utf-8?B?cXliVk40RjRUeUVMMkdnbXJqZDBxbTM0aGRkYW1BMlFZQjdjdFQrd1pTc3B3?=
 =?utf-8?B?SHRxZndQZzYzOHRUWEU0dmFod2huZkl4ejJvdXBnRzF2QWtjdVRIZ00vY2VF?=
 =?utf-8?B?OE0wNnFycUVSU0dMV0pwTW0vU25ramY4dmIwSGNKRUw3Q3BCUFNkR1pDUmVN?=
 =?utf-8?B?Q0paWWNDaS9KV0pIYVVPaThYOFc5ZkJDUmphc1NvZzN0ZjJEQmRTakJqakh1?=
 =?utf-8?B?TldrZlZhWml3WDNQQlMwdHNDM0g1MWtwMTVRQTBCNXhNSmNxQ1FZaDh5c2RE?=
 =?utf-8?B?ZUUvcVFlT1J2SzdxOWp4RmZnTkpHZDBUWHBRT3dMdWxZS2s3L3BDRldEZDNz?=
 =?utf-8?B?aHRob2pYQkE0eXAxMHZ1RkVJOE5mejQ3ZmxKcUMySVhBTWxWRnR1emhPZlN1?=
 =?utf-8?B?a3RvMjFpNXYyNGhKUTh4Ny9FTllTVXpGMGdML2ZORklpUTBKNS9DaEtDRS9t?=
 =?utf-8?B?UnZhSXdrZDNLV29NNStlSjd2Vm5lcWtPTi9aQVhDbkRuYmJiK0lYTEZ2L3JY?=
 =?utf-8?B?aXdPbFo5TUhGQllmOG9BMkd6dXFrbkQ0ekZUa2R2TmtJZmdHRnBHL1hDN3lh?=
 =?utf-8?B?Z0kwVHM3M2E1aFZjTmtoeXc0RWxLYU4xLzJFQlhLbldKUStkRWp0WUlhVXF5?=
 =?utf-8?B?TjRrWG9KQnFyYm5ncURZQXp6VTRFeFQ1d3hLbkJ1VUY2d2JuQkx5U2FldzVF?=
 =?utf-8?B?R3Q4SWUxMEFHZDhCdHRwbE84VUZsdzgvTUZOQi9DdmJCM05pZTYwVTdOTUxP?=
 =?utf-8?B?N1l4ckRwSVZYdFZqbVUyT01VL280RFllR25wOXhueUdab1ZPcmJ6SnhYM1A5?=
 =?utf-8?B?ejdOSlAxdzEzRzRtL09Jekhsa3VDYkVTdkIyNGhJdm1laVd6ZmtPU1I2UEo0?=
 =?utf-8?B?NVlWZXlDWmdBbElIZ1MvYnJVVFFjOEJ3QVRPTkIvREkxcmp1TGQ0NWY4OXBU?=
 =?utf-8?B?TC9hNGxwWlp5WXhXVlJuM2RoTnMzNk1nL3J0L2VoeG9FL2JtcFlaMnpBRWts?=
 =?utf-8?B?dVVvOWJqZktlUysvcjd0ZjhHTHVvSFlNalVVa05SbHVPbC9hck1TRjJ2WmVn?=
 =?utf-8?B?TWQxMldoRXA1TFZvVTBDYWg1cFhVSU5QVnlwelp2TUJPcCtCZ3VUVkd3ZzBS?=
 =?utf-8?B?N1RrckpWTEthaFVNak5vYU5TalBzME8wYU4xWGQ4TVZ5WDlSbVZSY043a3Yr?=
 =?utf-8?B?UGJJODVNNmgrZVROTkxsNDNiM1RSVDk5ck5JMSs1UnFyUDU3VWR6eVh5eVJw?=
 =?utf-8?B?a09FL2UzSmJxSzlOVzBackxQVldUZmh2MzdQRDNHcTZqMnl5eDFJYjBUWDc1?=
 =?utf-8?B?RmE2UFdkRS9pWmQ5SXNTa3dQUEVzWVhNMXlmRlJQRGxaRWp4dmNMQy8xTjhV?=
 =?utf-8?B?MDVEVVZCM3RWVHVLNlYzdWF3Y3VwRkpRU04xai9JTXIvWStXa3lvYlhpSzFj?=
 =?utf-8?B?N1lKdlR1ZkV5L3dHVFBqY05HY3RmcUFxMFFRRUFwUGRhVGxFeXpScFZ1T1Jw?=
 =?utf-8?B?Qm1BdW9TaFBqUU1zaHdOdTBlRG81VEJFcUtzUnREbmxqQkJ0Sy9rYks0SkdD?=
 =?utf-8?B?T0lOQUpkSUcvbXR1dDFScHhPZmJObm1EdmN5MUZ4TWlmQ0VwdUIrQUUvTXNx?=
 =?utf-8?B?T2ZsQnM3R1FoeUxqaStHWGpyQ1hLV3l2M3UrZ1AwT3A4YmJDNDlmbmcrVWZm?=
 =?utf-8?B?bHR5VXVrWER2WDc2Y3hLczkyOWoyZzBSbElERSt6dDZXbnVDVU04WWFWa1pZ?=
 =?utf-8?B?WTBVYWFweWFpU3ZUWE80K3B0VFhVRnY2a3lEZTU0YjlQdHJaTlltWmNseFdj?=
 =?utf-8?B?N1RGU1NjUUpiYkFhY3RQSFZRTXErOWVtcW53QXJRV2JObEd3QnJtRzhIblhH?=
 =?utf-8?B?UmxUQndHc0tZTFZLWVRhVnpMODRIVEFKcEd1RnhZanltdTZjZzJCZDU5cTk5?=
 =?utf-8?B?S2tRZXNlbCtrTWxKSy92SjVRd0taMWw0Z2RzenVQQzZxdEpDTStndHJPblZT?=
 =?utf-8?B?Y1R4TnY4a3hFeHdZZUMzbStWeDJxQlhTSit5OFZRWGpNRjdveThzTUJra3Fk?=
 =?utf-8?B?NVMrak5DTUh4clkrMVZLeTQ2Rld0OUZuOTBnY2VtbEZQditsdS9uNzRob0p3?=
 =?utf-8?Q?0jhz156Kr9+RDl9yRu?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <78FF89EFCBB6AE4B98A38C138886CAE2@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR06MB4072.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3beea42a-ef4d-4e1d-93a9-08d9f4d838be
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2022 01:19:35.0981
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Adm8Xm3Ht5rZAYbsXZ/hOmm/9xaiTqYxQYJ0o21tVjSJdpgWw+mnVX/+IOTIm+UnzeIEA+XrlJC/tbwTkBc2dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR06MB2928
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQoNCu+7v09uIDIvMjAvMjIsIDY6MTcgUE0sICJLdXJ0IEdhcmxvZmYiIDxrdXJ0QGdhcmxvZmYu
ZGU+IHdyb3RlOg0KDQogICAgTmV0QXBwIFNlY3VyaXR5IFdBUk5JTkc6IFRoaXMgaXMgYW4gZXh0
ZXJuYWwgZW1haWwuIERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVz
cyB5b3UgcmVjb2duaXplIHRoZSBzZW5kZXIgYW5kIGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4N
Cg0KDQoNCg0KICAgIEhpIE9sZ2EsDQoNCiAgICB0d28gdXBkYXRlczoNCg0KICAgIE9uIDIwLjAy
LjIyIDIzOjI2LCBLdXJ0IEdhcmxvZmYgd3JvdGU6DQogICAgPiBIaSBPbGdhLA0KICAgID4NCiAg
ICA+IHlvdXIgdXBzdHJlYW0gY29tbWl0IDE5NzZiMmIzLCBhcHBsaWVkIHRvIDUuMTUuMjQgYXMg
NmYyODM2MzQgYnJlYWtzIE5GUw0KICAgID4gZm9yIG1lLg0KICAgID4NCiAgICA+IFRoaXMgaXMg
d2hpbGUgbW91bnRpbmcgbWFueSBORlMgZmlsZXN5c3RlbXMgZnJvbSB0d28gTkZTIHNlcnZlcnMs
IG9uZQ0KICAgID4gUW5hcCAobmZzIHY0LjEpIGFuZCBvbmUgbGludXggNS4xNS4xNiBrbmZzZCAo
bmZzIHY0LjIpLg0KICAgIEkgaGF2ZSB0byBjb3JyZWN0IG15c2VsZi4gQWxsIHZvbHVtZXMgYnJv
a2VuIGJ5IDUuMTUuMjQgY29tZSBmcm9tIFFuYXAuDQogICAgPiBUaGUgTkZTIG1vdW50cyBqdXN0
IHdvdWxkIG5vdCBzdWNjZWVkLiBUaGlzIGFwcGVhcnMgdG8gaGFwcGVuIHRvIGFsbA0KICAgID4g
UW5hcCBtb3VudHMgYW5kIG9uZSBvZiB0aGUgbW91bnRzIGZyb20gdGhlIGxpbnV4IGtuZnNkLg0K
ICAgIFRoaXMgbW91bnQgYWxzbyBjYW0gZnJvbSBRbmFwIC0tIGluIG15IG1pbmQgSSBoYWQgbWln
cmF0ZWQgaXQgYWxyZWFkeSwNCiAgICBidXQgbm90IGluIHJlYWxpdHkgOi1PDQogICAgPiBJIGRp
ZCBzb21lIGJpc2VjdGluZyBpbiA1LjE1LjI0IC4uLiByZXZlcnRpbmcgNmYyODM2MzQgYW5kIHN1
YnNlcXVlbnQNCiAgICA+IE5GUy9zdW5SUEMgcGF0Y2hlcyBmcm9tIHlvdSBhbmQgWGl5dSwgQW5u
YSBkaWQgdGhlIHRyaWNrIHRvIHJlY292ZXIgZnJvbQ0KICAgID4gdGhpcyBmYWlsdXJlLg0KICAg
ID4gVG8gYmUgcHJlY2lzZTogSSByZXZlcnRlZCA0NDAzMjMzYiA0YjIyYWE0MiA1Y2ExMjNjOSBj
NWFlMThmYSBiZTY3YmU2YQ0KICAgID4gNmYyODM2MzQgMmRmNmE0N2EgMGM1ZDNiZmIgM2NiNWIz
MTcgNTg5NjdhMjMgYmJmNjQ3ZWMgYW5kIDM4YWU5Mzg3IGluDQogICAgPiA1LjE1LjI0LiBJIHN0
YXJ0ZWQgcmVlbmFibGluZyBhbmQgMmRmNmFhNjQ3YSBpcyB0aGUgbGFzdCBwYXRjaCB0aGF0DQog
ICAgPiBzdGlsbCByZXN1bHRzIGEgd29ya2luZyBORlMgZm9yIG1lLg0KDQogICAgQWxzbywgdGFr
aW5nIHBsYWluIDUuMTUuMjQgYW5kIGp1c3QgcmV2ZXJ0aW5nIDZmMjgzNjM0IGNyZWF0ZXMgYQ0K
ICAgIGtlcm5lbCB0aGF0IHdvcmtzIHdlbGwgd2l0aCBRbmFwIE5GUyBzaGFyZXMuDQoNCklzIGl0
IHBvc3NpYmxlIGZvciB5b3UgdG8gcHJvdmlkZSBhIG5ldHdvcmsgdHJhY2U/DQoNCiAgICBCZXN0
LA0KDQogICAgLS0NCiAgICBLdXJ0IEdhcmxvZmYgPGt1cnRAZ2FybG9mZi5kZT4NCg0KDQo=
