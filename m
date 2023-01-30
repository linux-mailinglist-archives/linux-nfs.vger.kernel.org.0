Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78EFC681DCC
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Jan 2023 23:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbjA3WL7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Jan 2023 17:11:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbjA3WL5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 30 Jan 2023 17:11:57 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2123.outbound.protection.outlook.com [40.107.223.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4094F3B658
        for <linux-nfs@vger.kernel.org>; Mon, 30 Jan 2023 14:11:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KOcFWVGpN6NK0r0K1bor2OeYmInLGp1U7/L06dUkEd6XR/s7P69zmPvzL8JQgvsjzvbtKN5TOR9R2A9enNfHvr+TER1z5z3M9i0O1z0U0uhDpvhkkdmOZpOO3REyE+w9ILGl0us8OYQGexnQR7aun9lq6k6fUjuPHVBxuOgVsJrEURKThxgyR3DwtNI9mA4nHAkUKI7Gw4q8WwPMK526Np6ZVtEVs3l/OFbk/vrikStSnGi+PwpCB9H9HirirU9GsvYokCPM10RL+MhNG+CeRO7Tyh/H6Gqzw76mCGisXEC+dwLCjh8FcRT5A8a+zO27t98JABTKVG1DvYiId8U3Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xJaPg8jLcN3AV7EGrPDMAafGrubDf2MZcWRXATzg0FU=;
 b=Q9HsrQ58HCJVasjNm7kN3J7IfRbD3wBkaVO43rWzHOX9SmbjZXoMQ/MxtWxXomKTBQwKhPHVF4+K68tgM9LtL+/LMLVPm4/dAyhoDxh5V/L2XQpL2+qXLy2TMa25V9SxYmy/TPaGV7VqMSBdr2cfjNpYLPMbufeMohiPQNBGKhzQrcrXRDJqofGbk/Y4+GpV5Xx3QnrxrNOIxw/6s4S7CTvS6Yp8biAubn5A5bawgPl2+LQAENKFduEnWtgjyf5nSjS89Yx0M2irxUIt4QkpNBHBqo3v/GPtoYok1vnmv5LO5IQXD/YnTjMpRl1j56sv86N82nqhjJ0tDJ/aOYt7Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fnal.gov; dmarc=pass action=none header.from=fnal.gov;
 dkim=pass header.d=fnal.gov; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fnal.gov; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJaPg8jLcN3AV7EGrPDMAafGrubDf2MZcWRXATzg0FU=;
 b=SmpGY6hS8S7zfU19pW1USVWVVjRQd+RMJfVyBBn4zv2Q4Ktln5fICRMIzHV0biKw3vy5xQa8FL1V0O8vnzLUyWfD+9Dqt6xz2cD8odJDTrjUKsVQRssAC3ue9QTCbGcDfNnyC9YAFFiKofIGTemiTbTWzKXFgpLeUulXp4HrJLStuLp3C1n15Dk8loPMjylk9hv6na7U88Vs7iV7fLPZx4eIVQH2I/5E8FmrNCiptdwTbUaU1z4mkaW9x3IUWu5vVDvV0er9U3hgmkKXgX4tSujqFc5RA9VBDZFyN2SZAuo/gkR0P8UoP/DRCVgEcNluuGEgGgP44Y0orFz7LcA0ig==
Received: from SA1PR09MB7552.namprd09.prod.outlook.com (2603:10b6:806:170::5)
 by SA1PR09MB8175.namprd09.prod.outlook.com (2603:10b6:806:171::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Mon, 30 Jan
 2023 22:11:52 +0000
Received: from SA1PR09MB7552.namprd09.prod.outlook.com
 ([fe80::2826:5e6f:8093:45f9]) by SA1PR09MB7552.namprd09.prod.outlook.com
 ([fe80::2826:5e6f:8093:45f9%7]) with mapi id 15.20.6043.036; Mon, 30 Jan 2023
 22:11:52 +0000
From:   "Andrew J. Romero" <romero@fnal.gov>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Zombie / Orphan open files 
Thread-Topic: Zombie / Orphan open files 
Thread-Index: AQHZNPfbZsyiVLox/EunGMra5E7rNQ==
Date:   Mon, 30 Jan 2023 22:11:52 +0000
Message-ID: <SA1PR09MB75521717AA00DCAD6CAB5118A7D39@SA1PR09MB7552.namprd09.prod.outlook.com>
References: <YQBPR01MB10724B629B69F7969AC6BDF9586C89@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
         <YQBPR01MB10724AEE306F99C844101EED086CF9@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
         <YQBPR01MB10724F79460F3C02361279E8686CF9@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
         <654e3b7d15992d191b2b2338483f29aec8b10ee1.camel@kernel.org>
         <YQBPR01MB10724B36E378F493B9DED3C7E86D39@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
         <3c02bd2df703a68093db057c51086bbf767ffeb1.camel@kernel.org>
         <YQBPR01MB1072428BC706EE8C5CC34341186D39@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
 <936efa478e786be19cb9715eba1941ebc4f94a1b.camel@kernel.org>
In-Reply-To: <936efa478e786be19cb9715eba1941ebc4f94a1b.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fnal.gov;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR09MB7552:EE_|SA1PR09MB8175:EE_
x-ms-office365-filtering-correlation-id: c8ee5507-9310-4f12-e187-08db030efdbc
x-fermilab-sender-location: inside
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Og0qR5dwlMtLyUiaMuAXbirf+o+GCtA+n/aFmkwRTV02BOXAwe42U6ugxR/jI6r3BdHsTeTjwMBzbWvkYEQ0KW/sFKPLtVgvt2SrE/kngxlfY2t4m70ewhDQKaZWkoBagNldYzPpce/h4MNTBCXby70MQ6C7Ez5fWBIqB0IgLetZyC2mT535w6MBCkRSqYFVS+y4tPzMR2vtGzCovkPF5C/i8Fo1pNqNNUOoxVVZS9fowOjMcICvUINs3A30E2OSZEEyYSolP7r3tbD+2F7Zd9V9s/abT7JPQyIGGDmEMJl0Kqwlov2S+wGhOckDZinSf4WxbIHso/xeyQjF8FNzCmyr3OqH2brXldk5Aw5itZvThs0DmDAxl7hOPV1p0Qa77oQ6d0An7FNqMmglFyRieaD2loycNwqjs2mjpHnagXQPYVRltqda8HsLS4/pBCslWq3zmRoXNrQ4Hdo2WCmeTOq/63o4JI6Kcul9npOFXi0hbS3Z6qNiIUN6k5Ax1Pjuu/WH90zq4OkaU8Ck35MOCLjXcDG/Vr6FU199aYORNIgGXyTvFc21nLNqlqi7rnuRvktue997EugkyUB+5nyJZW8kvZ7QRGDV/UcU+7NIgjn1vj3t13dRj11dlewRMQn/wgCSpl9NY0cSpVa9pUdFsMt+r9qVJ8r51cZm73KQ83wERVwwH+fHKPGnZmrtIlLp7zVbrRrXUDpecLIaTL7fvQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR09MB7552.namprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(451199018)(66476007)(66446008)(52536014)(8676002)(66556008)(66946007)(6916009)(64756008)(76116006)(8936002)(2906002)(5660300002)(66899018)(4744005)(508600001)(71200400001)(7696005)(186003)(9686003)(4743002)(6506007)(83380400001)(38100700002)(122000001)(38070700005)(86362001)(55016003)(33656002)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VTJCb05qNHY4LzZRWk9PUVlqbTh0bDhNVENoemhNU20vM2FOL0N5VjVQQ21G?=
 =?utf-8?B?eHNPVm1zNHpNZ2RZNjdpS3ZEYzZMM0d1MElKRlVUM1dZbDVLSTNuUGZlTzVR?=
 =?utf-8?B?WjFrM1k0bmxLVC9iSUZ6aExuaitBRGNINytEOWNkRVVuUU1sWTBVVmJFZWJi?=
 =?utf-8?B?SEF2dm45YTNQeVpRVCtDdE8wcGVHV0dtbURMYzZsWVNBOFBFRDV1RU8raFVm?=
 =?utf-8?B?d3RrZG5WM2FzVHhVYnNlbFNNZUFLK0dET3A2eFNiQmYvYTJ4RDNtQ1M4RmJ2?=
 =?utf-8?B?MklGcldycElRcWxBRENwUlowamNhSzJPRHdyS0ZNc2VRejMyZHJ3T2lvaThh?=
 =?utf-8?B?Z1VpQUdQWEhESG1SWnJoVWhuWGgxU3JCOC9vWFVqMUhxRy9Gdm5KeEpNbHdp?=
 =?utf-8?B?S0VEby9sRTRMSUd1Q3plMVFqall4RnFydmtxYUNCZ1lKWkZTMTRERTU5eXFy?=
 =?utf-8?B?NlRsK0JRYm5zSzljbFoxemFQbnJyY2J4aVB2VU5na01wMFVLMnF6U0JpOW9m?=
 =?utf-8?B?cURRU2lCeUs5WXhFTUN3dDR6L2xaSlRmRFBEU3A5SHlWeWtBMGVoNXF1OURJ?=
 =?utf-8?B?clBoRG5OQ20vY05SSmkvZ1hIREFycW9mQlBMZ2wxTzVOcU13cEp4MGJ1a2h0?=
 =?utf-8?B?NWRLV0U0NXJZbmN4RnJzM0hIRjI0UkorMXhDUUVFeXVISHZEQ0lOL1dibkl6?=
 =?utf-8?B?aUtUM1RwRWI0cTcxc2tFeHRpc3N5OUZqZll1WkU0ZkJUS25VWEd5ZVFqMm0z?=
 =?utf-8?B?YTFFRnJtaHNNYlNaVWF1NE5QV05IWE50STZvckhWZGtnck51V1NVMzhLYUll?=
 =?utf-8?B?OVJ5WHh2VlJDL1dZU1R5MWJybXdRUjVnSkVJajhrMTlZeFJVNThRUjR1ZUsw?=
 =?utf-8?B?VDlDUVRyMjhGdzhSTnRMNWdTdEJrWTl5RDhBZ0xjM3ZwVEJPQVNaZGZEelll?=
 =?utf-8?B?OEMrV2t1bXdGVk4rL0J1V2gyQmhwaVZEV2JlOVdVa2V3MGVITnFCVFI0QVdz?=
 =?utf-8?B?T2pOWVZtSG9EWGpUM2VQdHE1T1ZMLytmWmtRRVR5K1habUw2QXhxUi85d2RJ?=
 =?utf-8?B?VkJ0bEdBRUJKYnhYV2dwZnlCN0t0SEFYUXZ3QUJxZkRrTkpEdFVCQWpPZEx2?=
 =?utf-8?B?U1pGaGhFOVl0NjFpSnFtLzU4Z1B3M2ZPRzFWbjNISmNpZVhvekdtbzRjd09p?=
 =?utf-8?B?dXNnY1JOTlBTL0ZzU3NWaWwzU1pDZWJac01MdzBUeUJFNnpaZXdMbmVGOWU2?=
 =?utf-8?B?MUxiRWtpd282bXppc3prUTRhZDRjaDVWbEZhOWZVZ1pCRDVwUnA5WHFMZFFF?=
 =?utf-8?B?VHhaSnNkRjZ3SCsvbDJ6bk03R0QxbGxjK3ZKSlN6WStiSEhhKzJJMWhqV2gw?=
 =?utf-8?B?ZUJnVnJxbXpDM0N0UUprdUpERStZOWczbVRXZS9VOFgxbFpQc2x3WldmT3BC?=
 =?utf-8?B?VTdZSGwzb29pL3Nsb0tSYzBTbnArMnJ2UEQ3V3d0d3hRbmhmMmhOWENFUExD?=
 =?utf-8?B?ZmZQMWVqYkY0TjhSSVdUY2VnTGM5RjE3bWpXNEl0aHBMc1dHbjdiR3NhT3hC?=
 =?utf-8?B?cW44VDBEZFpGZ0Z2c2pweGVxVGVSNmhGVmRNN3pSNkhBcHJiNUNqSjMweGYx?=
 =?utf-8?B?eWFLMEdjVlhHMDlTUW5pSjFuTTZyZlY3TjB0Sm9UbFRZSHVmR1Qvd25UdDRL?=
 =?utf-8?B?cFpBa3Y3OUFCMStHREcwa2YzaUt2MFdXR0hBdEVLbmExNWd1WkFoRElTOFBZ?=
 =?utf-8?B?TGhYaVpLSjMwQWpPUW1HRzF3UlZFem4wbWJtdmhtdkllOGxjc1BMNW9HMTF6?=
 =?utf-8?B?YXcyMVFPRFd1QlZMc1dOS0pvWGpxbTZVdWFnaXA1ZnY4KzA4dnYzNmlya2J4?=
 =?utf-8?B?SWpJQTkyczdLZ0xsK1BURzlnN0Rxc0IrcEpPOUMrei9Va2htQWRPeXFHNXFk?=
 =?utf-8?B?anc4TGRPMTV2UXgwQnprc1NTSkgyUnFiYVdQNVlhbW40SXBpV3JBa2lrWGJU?=
 =?utf-8?B?K3Q1WFBzYU5UNzJoUWNuU0VlbU15amFhZG9qUklDRDV6M3ZWdzhKZGpUdnV2?=
 =?utf-8?B?cm5OMjNMSXNLT0NUdlVSdFd0Wm1kZ2t3dDJwSDIyaGJLT0N0UncralhQUE1z?=
 =?utf-8?B?OFpRWWI0MlM4bU5HczRpTEVRdTlxVHhPc2xrV1N6R2w2U2llMDN3eFNta3U4?=
 =?utf-8?Q?E5/EAMLmzDFCHs4p8BTFgc/6Zu79lLsoG2nH1eAeUjlt?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fnal.gov
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR09MB7552.namprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8ee5507-9310-4f12-e187-08db030efdbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2023 22:11:52.4341
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9d5f83d3-d338-4fd3-b1c9-b7d94d70255a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR09MB8175
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_GOV_DKIM_AU,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

SGkNCg0KVGhpcyBpcyBhIHF1aWNrIGdlbmVyYWwgTkZTIHNlcnZlciBxdWVzdGlvbi4NCg0KRG9l
cyB0aGUgTkZTdjR4ICBzcGVjaWZpY2F0aW9uIHJlcXVpcmUgb3IgcmVjb21tZW5kIHRoYXQ6ICAg
dGhlIE5GUyBzZXJ2ZXIsIGFmdGVyIHNvbWUgcmVhc29uYWJsZSB0aW1lLCANCnNob3VsZCAvIG11
c3QgY2xvc2Ugb3JwaGFuIC8gem9tYmllIG9wZW4gZmlsZXMgPw0KDQpPbiBzZXZlcmFsIE5BUyBw
bGF0Zm9ybXMgSSBoYXZlIHNlZW4gbGFyZ2UgbnVtYmVycyBvZiBvcnBoYW4gLyB6b21iaWUgb3Bl
biBmaWxlcyAicGlsZSB1cCIgDQphcyBhIHJlc3VsdCBvZiBLZXJiZXJvcyBjcmVkZW50aWFsIGV4
cGlyYXRpb24uDQoNCkRvZXMgdGhlIFJlZCBIYXQgTkZTIHNlcnZlciAiZGVhbCB3aXRoIiBvcnBo
YW4gLyB6b21iaWUgb3BlbiBmaWxlcyA/DQoNClRoYW5rcw0KDQpBbmR5IFJvbWVybw0KRmVybWls
YWINCg0KDQo=
