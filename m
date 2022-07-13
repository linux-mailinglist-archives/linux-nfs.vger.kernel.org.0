Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70A84573B21
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Jul 2022 18:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237069AbiGMQZM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 13 Jul 2022 12:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234652AbiGMQZJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 13 Jul 2022 12:25:09 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2118.outbound.protection.outlook.com [40.107.117.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DFB96
        for <linux-nfs@vger.kernel.org>; Wed, 13 Jul 2022 09:25:07 -0700 (PDT)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=nLA+IGsflf3utUD79BEFhMWp3fl2qTev41RPYqG9mqmYL+JNixdD9DPCrqfBffsLLZKnLILx577wRfnPmKfJM7FLZcvkbaPkDQYYKkG7kr5kEDpSz2F7fS8Wmeb5HOsj+cijwLoA6yzO+8MtUSOmvdPmAU0L+eAKUDGFLzekVTsL3AOgl4M3Yc6d/0lgr3pyozaiys04VrD0vf3/EMBJev9XIeG1iFhj/bZu6tpft5tVjI9/yYZPaJ/o6Th7P5C/BgnjN+2qvFNo823f3cA+Lu81l+SW79y5vQt55RXf2R0kxT357Vd8iGAwYshqJ0oM8HHNVu2hwCg25BzUUqqpyA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=55sMgjD28N1TWBw4jZQYLeyzOkoSCRgVvgvMaGMUe4E=;
 b=oSQzimk/zo6d3YIb5CwHJX8pE5j606J4NsrT60IAq0gyfzpn6nL8slwjf5j5dtiInhNkCVwVYqpSkQJlqC3KwwWW4MfW+px57R21a3H3guphVqFcCOa/WdpZCn3C4ES95Q8kyR5jlOitXme6dwF/pv2cJxq3JkW5ItxW3Lpi2it1bo3/9AOoYI4GRXlctmGWCGVSulNuX+UBba1gX6e8c9I6xFx7mVhXJYo0Z+y8yoGOZbL9sFbLFk3gDKFcyltuBM5j1xKx5U6DZBTmXbQoOxXRxxHwf8PoTVk/v82X+nFOYlryUvLj3r+kIf9DBHzGFFKCmbDt+qeo2uw2oM9pQw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 192.8.245.54) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=hcl.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=hcl.com;
 dkim=pass (signature was verified) header.d=hcl.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=hcl.com] dkim=[1,1,header.d=hcl.com]
 dmarc=[1,1,header.from=hcl.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HCL.COM; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=55sMgjD28N1TWBw4jZQYLeyzOkoSCRgVvgvMaGMUe4E=;
 b=ryWi07VnnFlHvTBocIOSwLDCXkjp34FWJ1dbhVFe6U0Mw3zu0yOZBF4yWCtosIAYzR7WvME3q312Ml1CSGh5dpfAcjnbHiVbrSPodTYra+2vHCzeUkn7Kufq9WNIICVP9lfaQ6BS/XICsgqNzGWbcmOIuvQJN0wsWwrQoLYxxb7p/+CorXMS9h47vhCYAr0zmAXiOUQ4hHZEmvzfAuKyxdEjLhj0C4PRy7/iKFkrfvIHLm/7vf0NB+TiMoGZh25PzpVUwgIh3tgOmz9Nx9ukBJYgckdPrLdPbIRZ+opT+x03YEsBGJQzFPq4B+M8a6zt1mj4/DenXpOy7milnRTzSA==
Received: from SG2P153CA0026.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::13) by
 PUZPR04MB5201.apcprd04.prod.outlook.com (2603:1096:301:bc::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.20; Wed, 13 Jul 2022 16:25:05 +0000
Received: from SG2APC01FT0025.eop-APC01.prod.protection.outlook.com
 (2603:1096:4:c7:cafe::a1) by SG2P153CA0026.outlook.office365.com
 (2603:1096:4:c7::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.3 via Frontend
 Transport; Wed, 13 Jul 2022 16:25:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.8.245.54)
 smtp.mailfrom=hcl.com; dkim=pass (signature was verified)
 header.d=HCL.COM;dmarc=pass action=none header.from=hcl.com;
Received-SPF: Pass (protection.outlook.com: domain of hcl.com designates
 192.8.245.54 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.8.245.54; helo=APC01-TYZ-obe.outbound.protection.outlook.com;
 pr=C
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (192.8.245.54) by
 SG2APC01FT0025.mail.protection.outlook.com (10.13.36.187) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.12 via Frontend Transport; Wed, 13 Jul 2022 16:25:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uba/a/I3V6k2qOdEHq+/UvpTavh8m+HdlsLs01zXs7pewFCOE/kWEqWDj/6vkG7AN0jG3XH6ow1hcR8SPn6eN9tQTt19Bau67iXzDf59fyGR09a0WmKdWUfuyIEZnPhBlg1Vc3NKEHVy60O7GCCMDeuC/Oj3YbidD9RJt1gKjre4mxAwYryj1A3dk8NLtBgi/oFsuZInI9+IWhk2lUjlw0nMKu/+A/3a1s0/+DlEm5Hf3bTDenKAIbGwMW7EfAB7cRqc/sj7hSPtTDH9cJJXj241ssuThkrvYD3CbsDWC0BZJhjPVgF40eqVFIVhtN9DvxZbRoyaLpjC1Hu9PRiCDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=55sMgjD28N1TWBw4jZQYLeyzOkoSCRgVvgvMaGMUe4E=;
 b=NQgpUplr+jWaGhX20OvWXdsZ3m194XKttYslgT2tFOhF2iF4vXGOhj/V0Yvuxd4VEj/pgz63c6kURMfI5Vl+8aDDs9lCqiA2SWv2eZMImv+7vYJMmvERZlmtJe8PxeuXoElEPaHOWYUSl5FaNuvZc/yW/vdmHYuB/+7HylPww0YAxeX44aAOYuU3/mwdkIblk8iLBHRhVvqoFm/A8ATk1zvPIQTB8dHCe4f+dmBVCVscUuV3PpGESzWP94NbbuvVAoS7ztyuAbC76zFJg84vmK58u3G2sIvSc8d6uhuyqvKGKA/JvO0ToVclujaRMGyYa+jA2VB5DJaM1x5s3RRnZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hcl.com; dmarc=pass action=none header.from=hcl.com; dkim=pass
 header.d=hcl.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HCL.COM; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=55sMgjD28N1TWBw4jZQYLeyzOkoSCRgVvgvMaGMUe4E=;
 b=ryWi07VnnFlHvTBocIOSwLDCXkjp34FWJ1dbhVFe6U0Mw3zu0yOZBF4yWCtosIAYzR7WvME3q312Ml1CSGh5dpfAcjnbHiVbrSPodTYra+2vHCzeUkn7Kufq9WNIICVP9lfaQ6BS/XICsgqNzGWbcmOIuvQJN0wsWwrQoLYxxb7p/+CorXMS9h47vhCYAr0zmAXiOUQ4hHZEmvzfAuKyxdEjLhj0C4PRy7/iKFkrfvIHLm/7vf0NB+TiMoGZh25PzpVUwgIh3tgOmz9Nx9ukBJYgckdPrLdPbIRZ+opT+x03YEsBGJQzFPq4B+M8a6zt1mj4/DenXpOy7milnRTzSA==
Received: from SI2PR04MB5821.apcprd04.prod.outlook.com (2603:1096:4:1e5::8) by
 TY2PR04MB3038.apcprd04.prod.outlook.com (2603:1096:404:a4::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.16; Wed, 13 Jul 2022 16:25:01 +0000
Received: from SI2PR04MB5821.apcprd04.prod.outlook.com
 ([fe80::818:6a8:839e:1e27]) by SI2PR04MB5821.apcprd04.prod.outlook.com
 ([fe80::818:6a8:839e:1e27%5]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 16:25:01 +0000
From:   Brian Cowan <brian.cowan@hcl.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: RE: Any way to make the NFS server ALWAYS report its NFS domain name
 when returning an ACL?
Thread-Topic: Any way to make the NFS server ALWAYS report its NFS domain name
 when returning an ACL?
Thread-Index: AdiTCInhEYXITo0+QLKqItlSwqlPKADyrQxA
Date:   Wed, 13 Jul 2022 16:25:01 +0000
Message-ID: <SI2PR04MB5821A7DA694AED727B99DAC5FE899@SI2PR04MB5821.apcprd04.prod.outlook.com>
References: <SI2PR04MB58213B077411EC88ECD11124FE829@SI2PR04MB5821.apcprd04.prod.outlook.com>
In-Reply-To: <SI2PR04MB58213B077411EC88ECD11124FE829@SI2PR04MB5821.apcprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-rorf: true
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcYnJpYW4uY293YW5cYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy01NWVjMzE1Yy0wMmM4LTExZWQtODlkYy1mOGU0ZTNkOGYxZjdcYW1lLXRlc3RcNTVlYzMxNWUtMDJjOC0xMWVkLTg5ZGMtZjhlNGUzZDhmMWY3Ym9keS50eHQiIHN6PSI1MTkzIiB0PSIxMzMwMjIwMzA5ODY3ODkwODkiIGg9Ilg2b3p2Wm8xQWxqUElvMXFtMDRiUHI5VE01RT0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hcl.com;
X-MS-Office365-Filtering-Correlation-Id: 6a4f5654-2e14-4023-ece7-08da64ec3e61
x-ms-traffictypediagnostic: TY2PR04MB3038:EE_|SG2APC01FT0025:EE_|PUZPR04MB5201:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: WOO3jpDWkww0+98WV9RUcy6BVq9CnPsOR3ZXKtOQE9beQCzWyWh6J3wHF6XqrG3QJrGTPWhyoUwO8z3WfNIOQTIeIVgAQ94GQFpNpQFahKbcArstGuPbVRpIkU2GEMiDYu+yj7mplP+yvAQdC5veA4YHwSAp54AUzwaBSCEHhSl29lljnn/NGO12DIlztNSXkPWibUxKXYM3h8VTJ88FimDxLoVC48D1XU2KlcbSz4FLSld2qbHgbQ0XfmsIVXIrVHPH6qX8CeqUGVm7EK7ivtoQBZtXftISnD9iEJ0UfO4CdEFKe9enhvDEJ8D1ePl1EKf+JAnzTEbu0AV9tNklYVwvGViQqkADxtNRtkFMb/Hb8tdkZWWMmlNfj6B2K7MswgS+1jjbuyOos4TAbkSyVeNdw7IH2DIU4qhKhcmE0wH+94Lyb1DnoTrUO/2fGvM3QwSpUSlQi23yVFCMMG7BDnB1W5Bq0MFIT8wwiP8ImgIPtzsZ1f2YJ6gG/WFzLVuNNAdZV1x8OUumsF6eDrK6uLvNFFl5q1XiTNQyxdFuEXryLQvXLFeLPnK8aLpflFgDuZ8W8woORZmWPX150p6vEUSL8NYbOry9eUYj75f1C0CuvZ2J5LBe0TYgcJLykM9I4g6JF8cRSvE8ZdgETJAZTXtZKPSnsg2ZUdbRvNAQLgs/TAI7E+TDDFtFzYaZ9zJ6//arfJkVAiETCZp37HWM46dW61mGl4BQpKVGxZkO9nqPZV0g9uOr0XMZps+M5iRtrnV4b1VZvbs/5AaVie5F60Lh4PKzTjaPAvBT7/YOmhWSKJsUIHOr3f03HTBhPCiH+aZx9nSQ50xTkYixHEj94w==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR04MB5821.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(366004)(376002)(396003)(346002)(39860400002)(186003)(55016003)(38070700005)(316002)(38100700002)(122000001)(66556008)(6916009)(45080400002)(66446008)(83380400001)(66946007)(64756008)(9686003)(8676002)(66476007)(76116006)(71200400001)(33656002)(8936002)(5660300002)(52536014)(7696005)(26005)(86362001)(6506007)(82960400001)(2906002)(41300700001)(478600001)(44832011)(53546011)(43043002);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR04MB3038
X-DLP:  MSGProcess
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: SG2APC01FT0025.eop-APC01.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 543fc1d2-359e-45d6-a3db-08da64ec3c9d
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4ojt9X9Kbq7ARus3SP/aQoOwpTCYI6b46JU6su2bSNWZLBFbScRZTD3SL5rlvWuXBnqD3daDGF6L//sDMZIE28tdkG29Mvuwh9pVwjnlyTTCvIgyJoOZ8Nvs73iAe3x13/YqzXeS3LxIzrmUrkDBxy29ylM2OPGyHKbeR8DiDGsdGvW+bZNSfFcCZJ0ksZKSeG8vgKdDogw7vJ+Tr1mT6k9Y/c6HF/vePyDcY0K1IDuUx2toX4K9lTZxWJf2Zn1uE8hZjViZOzAi6/Dhtll4hU7Se6riyBf3jc2+r1HwHW/8ZYF2vGo1BRPP+ytfBQOsXvdNbffMYQhyc8OyPW3fl0VAwS+2wLCRrfUZ0EPnOyaZW+o85IxJ6H/63tq9Fslocdt1/d7tToppker71GE6NMRB3R5Qaa0DzToebkUA/exhlnxBeX1GwCiIohqFfCtyh4Y+bqiq/EpEkVKGQy1zvcdYzQRmN/TnbjRD8eVqHrzbi8xocDGwoBB7VLyJDk1Xqrtq/L4HQvwGxeh/whKPst+c1qFuOzGPI/SCVUltUAFeXITKFjzbrTMNem2XAKnAoJ31B05Tgnj+1uEypAsPTImUdn7kEVNq5IT2WsDiV9TNfJfsi4u8D0p5uOqds4gy0JWLadLjESMkSZIHrkNHId1zfUhJucv9ZBDxx66rjW2q9dUsG5V/YB1C0IsAusCxXfJlo1MyyKsUFTd/+aHCxYYB/prw0yoDygnMgz8jeFh+wT1lIbMI67OPwTWZCzL8X7XuaWnyTWWPYsipyxNShC275f0bXpujK1aBfGzm7uZ1sy1eBKq+wSZDpRp8GcWoReYb8Zco1gU4sXbHBGOi0t6VOqLMRTCvSPDQq8ot63vxRXeEe7JUxM16Bz8O1WYm
X-Forefront-Antispam-Report: CIP:192.8.245.54;CTRY:IN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:APC01-TYZ-obe.outbound.protection.outlook.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(396003)(39860400002)(376002)(40470700004)(36840700001)(46966006)(44832011)(45080400002)(86362001)(2906002)(70586007)(186003)(36906005)(316002)(36860700001)(55016003)(478600001)(5660300002)(52536014)(40460700003)(82310400005)(81166007)(8936002)(83380400001)(6506007)(47076005)(336012)(53546011)(40480700001)(356005)(70206006)(33656002)(41300700001)(82740400003)(26005)(8676002)(82960400001)(9686003)(7696005)(6916009)(43043002)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: HCL.COM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 16:25:04.4886
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a4f5654-2e14-4023-ece7-08da64ec3e61
X-MS-Exchange-CrossTenant-Id: 189de737-c93a-4f5a-8b68-6f4ca9941912
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=189de737-c93a-4f5a-8b68-6f4ca9941912;Ip=[192.8.245.54];Helo=[APC01-TYZ-obe.outbound.protection.outlook.com]
X-MS-Exchange-CrossTenant-AuthSource: SG2APC01FT0025.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR04MB5201
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

UGxlYXNlIGZvcmdpdmUgbXkgcmVwbHlpbmcgdG8gbXlzZWxmLCBidXQgLS0gYWZ0ZXIgYSByYXRo
ZXIgdW5mb3J0dW5hdGUgbG9zcyBvZiB0aGUgU1NEIG15IHRlc3QgVk0ncyB3ZXJlIG9uIC0tIEkn
bSByZWNyZWF0aW5nIG15IHRlc3QgZW52aXJvbm1lbnRzLi4uICoqQW5kIHRoZSBuZnMgQUNFJ3Mg
YXJlIGNvbWluZyBhY3Jvc3MgYXMgInVzZXIvYXQvZG9tYWluIiBpbnN0ZWFkIG9mIGp1c3QgInVz
ZXIuIioqICgiL2F0LyIgdXNlZCBiZWNhdXNlIE91dGxvb2sgaW5zaXN0cyBvbiB0cnlpbmcgdG8g
dHVybiBpdCBpbnRvIGEgIm1haWx0byIgbGluayBldmVuIGluICJwbGFpbiB0ZXh0IiBtZXNzYWdl
cy4pDQoNClVuZm9ydHVuYXRlbHkgaXQncyBwaHlzaWNhbGx5IGltcG9zc2libGUgdG8gZ2V0IHRv
IHRoZSBkYXRhIG9uIHRoZSBvbGQgU1NELCBzbyBJIGNhbid0IGNvbXBhcmUgdGhlIHNldHRpbmdz
IHRvIHNlZSB3aGF0IEkgZGlkIGRpZmZlcmVudGx5IG9yIHdyb25nLiBJIGtub3cgSSdtIG5vdCB0
aGUgb25seSBwZXJzb24vb3JnYW5pemF0aW9uIHRoYXQgaGFzIHRoaXMgaGFwcGVuLCBiZWNhdXNl
IEkgaGF2ZSBhIHJhdGhlci1sYXJnZSAoYXMgaW4gInN0cmF0ZWdpY2FsbHkgaW1wb3J0YW50IHRv
IGNvbXBhbnkiKSBjbGllbnQgd2hvIGhpdCB0aGUgaXNzdWUgYXMgSSB3YXMgZXhwZXJpbWVudGlu
ZyB3aXRoIHRoaXMgdG8gcmVwcm9kdWNlIGEgKmRpZmZlcmVudCogaXNzdWUuIA0KDQpJZiB0aGlz
IGlzbid0IHRoZSByaWdodCBsaXN0LCBjYW4gc29tZW9uZSBwbGVhc2UgcG9pbnQgbWUgdG8gdGhl
IHJpZ2h0IG9uZT8gSSBvbmx5IHNlZSB0aGUgb25lIGxpc3Qgb24gdGhlIG1ham9yZG9tbyBwYWdl
Lg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogQnJpYW4gQ293YW4gPGJyaWFu
LmNvd2FuQGhjbC5jb20+IA0KU2VudDogRnJpZGF5LCBKdWx5IDgsIDIwMjIgNDozOSBQTQ0KVG86
IGxpbnV4LW5mc0B2Z2VyLmtlcm5lbC5vcmcNClN1YmplY3Q6IEFueSB3YXkgdG8gbWFrZSB0aGUg
TkZTIHNlcnZlciBBTFdBWVMgcmVwb3J0IGl0cyBORlMgZG9tYWluIG5hbWUgd2hlbiByZXR1cm5p
bmcgYW4gQUNMPw0KDQpbQ0FVVElPTjogVGhpcyBFbWFpbCBpcyBmcm9tIG91dHNpZGUgdGhlIE9y
Z2FuaXphdGlvbi4gVW5sZXNzIHlvdSB0cnVzdCB0aGUgc2VuZGVyLCBEb27igJl0IGNsaWNrIGxp
bmtzIG9yIG9wZW4gYXR0YWNobWVudHMgYXMgaXQgbWF5IGJlIGEgUGhpc2hpbmcgZW1haWwsIHdo
aWNoIGNhbiBzdGVhbCB5b3VyIEluZm9ybWF0aW9uIGFuZCBjb21wcm9taXNlIHlvdXIgQ29tcHV0
ZXIuXQ0KDQpIaSBhbGwsIExvbmcgdGltZSBzaW5jZSBJIHdhc24ndCBhIGx1cmtlciBoZXJlLi4u
DQoNCkFmdGVyIHNvbWUgc2VyaW91cyBnb29nbGUtd2hhY2tpbmcsIEkgbWFuYWdlZCB0byBnZXQg
YSBSSEVMIDguNiBORlMgc2VydmVyIHRvIHJldHVybiBORlN2NCBBQ0wncyBmb3IgZmlsZXMgd2hl
cmUgdGhlIGVudHJpZXMgd2VyZSBuYW1lcyBhbmQgbm90IG51bWJlcnMuLi4gSXQgZmVlbHMgYSBs
aXR0bGUga2x1ZGd5IHRvIG1lIHRvIGNyZWF0ZSBhIHNjcmlwdCB0byBzZXQgdGhlIG5mc2Qgb3B0
aW9ucyBpbiAvZXRjL21vZHByb2JlLmQuLi4gQnV0IGFueXdheXMuLi4NCg0KVGhlIGlzc3VlIEkn
bSBjdXJyZW50bHkgZGVhbGluZyB3aXRoIGlzIHRoYXQgLS0gYXQgbGVhc3QgZm9yIGhvc3RzIGlu
IHRoZSBzYW1lICJuZnMgZG9tYWluIiAoc2FtZSBEb21haW4gaW4gaWRtYXBkLmNvbmYsIGFuZCB1
c2luZyB0aGUgc2FtZSBBRCBkb21haW4gdmlhIHNzc2QpIC0tIG5mczRfZ2V0ZmFjbCByZXBvcnRz
IGJhcmUgbmFtZXMgaW4gdGhlIEFDTCBlbnRyaWVzLiBGb3IgZXhhbXBsZToNCi0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpbdm9iYWRtQHZ2LTMwLXJoODUgfl0kICBuZnM0X2dldGZh
Y2wgL25ldC9iYy1yaDg2LW5mcy9leHBvcnQvbmZzL3ZvYnN0b3JlL3NpZGR1bXB0ZXN0LXJlcC52
YnMvcy9zZGZ0LzNjLzEzLzItMGY0MTgxN2I2N2ZjMTFlYzg0ZTI1MjU0MDBjOTAyODctdDcNCiMg
ZmlsZTogL25ldC9iYy1yaDg2LW5mcy9leHBvcnQvbmZzL3ZvYnN0b3JlL3NpZGR1bXB0ZXN0LXJl
cC52YnMvcy9zZGZ0LzNjLzEzLzItMGY0MTgxN2I2N2ZjMTFlYzg0ZTI1MjU0MDBjOTAyODctdDcN
CkE6Ok9XTkVSQDpydFRjQ3kNCkE6OmEuaHVtYW4udXNlcjpydGN5DQpBOjp2b2JhZG06cnRjeQ0K
QTo6R1JPVVBAOnJ0Y3kNCkE6ZzpjY3VzZXJzOnJ0Y3kNCkE6Zzphc2RmXzA6cnRjeQ0KQTo6RVZF
UllPTkVAOnJ0Y3kNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQoNClRoZSBwcm9i
bGVtIGlzLCB0aGUgYXBwbGljYXRpb24gdGhhdCBpcyB2ZXJpZnlpbmcgdGhlIE5GUzQgQUNMIGFn
YWluc3QgcGVybWlzc2lvbnMgc3RvcmVkIGluIGEgZGF0YWJhc2UgKFllcywgaXQncyBzdGlsbCBD
bGVhckNhc2UsIGFuZCBDbGVhckNhc2UgaXMgc3RpbGwgYXJvdW5kKSBpcyB3cml0dGVuIGFzc3Vt
aW5nIHRoYXQgdGhlIGFib3ZlIG91dHB1dCByZWFkcyBsaWtlIHRoaXM6DQotLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLQ0KW3ZvYmFkbUB2di0zMC1yaDg1IH5dJCAgbmZzNF9nZXRmYWNs
IC9uZXQvYmMtcmg4Ni1uZnMvZXhwb3J0L25mcy92b2JzdG9yZS9zaWRkdW1wdGVzdC1yZXAudmJz
L3Mvc2RmdC8zYy8xMy8yLTBmNDE4MTdiNjdmYzExZWM4NGUyNTI1NDAwYzkwMjg3LXQ3DQojIGZp
bGU6IC9uZXQvYmMtcmg4Ni1uZnMvZXhwb3J0L25mcy92b2JzdG9yZS9zaWRkdW1wdGVzdC1yZXAu
dmJzL3Mvc2RmdC8zYy8xMy8yLTBmNDE4MTdiNjdmYzExZWM4NGUyNTI1NDAwYzkwMjg3LXQ3DQpB
OjpPV05FUkA6cnRUY0N5DQpBOjphLmh1bWFuLnVzZXJAc3d0ZXN0LmxvY2FsOnJ0Y3kNCkE6OnZv
YmFkbUBzd3Rlc3QubG9jYWw6cnRjeQ0KQTo6R1JPVVBAOnJ0Y3kNCkE6ZzpjY3VzZXJzQHN3dGVz
dC5sb2NhbDpydGN5DQpBOmc6YXNkZl8wQHN3dGVzdC5sb2NhbDpydGN5DQpBOjpFVkVSWU9ORUA6
cnRjeQ0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCg0KR2V0dGluZyB0byB0aGlz
IHBvaW50IHdhcyBzb21ldGhpbmcgb2YgYSBsb25nIHJvYWQgaW52b2x2aW5nIGJ1aWxkaW5nIGlu
c3RydW1lbnRlZCBjb2RlIHRvIHRlbGwgbWUgc29tZXRoaW5nIG90aGVyIHRoYW4gIm5vLCBJIGRv
bid0IGxpa2UgdGhlIEFDTC4uLiINCg0KVGhlIGZpbGUgaW4gcXVlc3Rpb24gbG9va3MgbGlrZSB0
aGlzIG9uIHRoZSBORlMgc2VydmVyOg0KW3Rlc3R1c2VyQGJjLXJoODYtbmZzIH5dJCBnZXRmYWNs
IC9leHBvcnQvbmZzL3ZvYnN0b3JlL3NpZGR1bXB0ZXN0LXJlcC52YnMvcy9zZGZ0LzNjLzEzLzIt
MGY0MTgxN2I2N2ZjMTFlYzg0ZTI1MjU0MDBjOTAyODctdDcNCmdldGZhY2w6IFJlbW92aW5nIGxl
YWRpbmcgJy8nIGZyb20gYWJzb2x1dGUgcGF0aCBuYW1lcyAjIGZpbGU6IGV4cG9ydC9uZnMvdm9i
c3RvcmUvc2lkZHVtcHRlc3QtcmVwLnZicy9zL3NkZnQvM2MvMTMvMi0wZjQxODE3YjY3ZmMxMWVj
ODRlMjUyNTQwMGM5MDI4Ny10Nw0KIyBvd25lcjogdm9iYWRtDQojIGdyb3VwOiBhc2RmXzANCnVz
ZXI6OnItLQ0KdXNlcjphLmh1bWFuLnVzZXI6ci0tDQp1c2VyOnZvYmFkbTpyLS0NCmdyb3VwOjpy
LS0NCmdyb3VwOmNjdXNlcnM6ci0tDQpncm91cDphc2RmXzA6ci0tDQptYXNrOjpyLS0NCm90aGVy
OjpyLS0NCg0KSXMgaXQgcG9zc2libGUgdG8gbWFrZSB0aGUgTkZTIHNlcnZlciBob3N0IGFsd2F5
cyByZXBvcnQgdGhlIE5GUyBkb21haW4gbmFtZSBpbiByZXNwb25zZSB0byB0aGlzIHJlcXVlc3Q/
IEJlY2F1c2UgaWYgdGhlcmUgaXMsIGl0J3MgZWl0aGVyIHdlbGwgaGlkZGVuIG9yIEknbSBoYXZp
bmcgbXkgdXN1YWwgaXNzdWVzIHdpdGggc3R1ZmYgc3RhcmluZyBtZSBpbiB0aGUgZmFjZS4uLg0K
DQpUaGFua3MgaW4gYWR2YW5jZQ0KDQpCcmlhbg0KOjpESVNDTEFJTUVSOjoNCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fDQpUaGUgY29udGVudHMgb2YgdGhpcyBlLW1haWwgYW5kIGFu
eSBhdHRhY2htZW50KHMpIGFyZSBjb25maWRlbnRpYWwgYW5kIGludGVuZGVkIGZvciB0aGUgbmFt
ZWQgcmVjaXBpZW50KHMpIG9ubHkuIEUtbWFpbCB0cmFuc21pc3Npb24gaXMgbm90IGd1YXJhbnRl
ZWQgdG8gYmUgc2VjdXJlIG9yIGVycm9yLWZyZWUgYXMgaW5mb3JtYXRpb24gY291bGQgYmUgaW50
ZXJjZXB0ZWQsIGNvcnJ1cHRlZCwgbG9zdCwgZGVzdHJveWVkLCBhcnJpdmUgbGF0ZSBvciBpbmNv
bXBsZXRlLCBvciBtYXkgY29udGFpbiB2aXJ1c2VzIGluIHRyYW5zbWlzc2lvbi4gVGhlIGUgbWFp
bCBhbmQgaXRzIGNvbnRlbnRzICh3aXRoIG9yIHdpdGhvdXQgcmVmZXJyZWQgZXJyb3JzKSBzaGFs
bCB0aGVyZWZvcmUgbm90IGF0dGFjaCBhbnkgbGlhYmlsaXR5IG9uIHRoZSBvcmlnaW5hdG9yIG9y
IEhDTCBvciBpdHMgYWZmaWxpYXRlcy4gVmlld3Mgb3Igb3BpbmlvbnMsIGlmIGFueSwgcHJlc2Vu
dGVkIGluIHRoaXMgZW1haWwgYXJlIHNvbGVseSB0aG9zZSBvZiB0aGUgYXV0aG9yIGFuZCBtYXkg
bm90IG5lY2Vzc2FyaWx5IHJlZmxlY3QgdGhlIHZpZXdzIG9yIG9waW5pb25zIG9mIEhDTCBvciBp
dHMgYWZmaWxpYXRlcy4gQW55IGZvcm0gb2YgcmVwcm9kdWN0aW9uLCBkaXNzZW1pbmF0aW9uLCBj
b3B5aW5nLCBkaXNjbG9zdXJlLCBtb2RpZmljYXRpb24sIGRpc3RyaWJ1dGlvbiBhbmQgLyBvciBw
dWJsaWNhdGlvbiBvZiB0aGlzIG1lc3NhZ2Ugd2l0aG91dCB0aGUgcHJpb3Igd3JpdHRlbiBjb25z
ZW50IG9mIGF1dGhvcml6ZWQgcmVwcmVzZW50YXRpdmUgb2YgSENMIGlzIHN0cmljdGx5IHByb2hp
Yml0ZWQuIElmIHlvdSBoYXZlIHJlY2VpdmVkIHRoaXMgZW1haWwgaW4gZXJyb3IgcGxlYXNlIGRl
bGV0ZSBpdCBhbmQgbm90aWZ5IHRoZSBzZW5kZXIgaW1tZWRpYXRlbHkuIEJlZm9yZSBvcGVuaW5n
IGFueSBlbWFpbCBhbmQvb3IgYXR0YWNobWVudHMsIHBsZWFzZSBjaGVjayB0aGVtIGZvciB2aXJ1
c2VzIGFuZCBvdGhlciBkZWZlY3RzLg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18N
Cg==
