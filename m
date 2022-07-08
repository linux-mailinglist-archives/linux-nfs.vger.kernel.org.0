Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E53056C2DE
	for <lists+linux-nfs@lfdr.de>; Sat,  9 Jul 2022 01:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239992AbiGHUiz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 8 Jul 2022 16:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239251AbiGHUix (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 8 Jul 2022 16:38:53 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2108.outbound.protection.outlook.com [40.107.117.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E827AA0249
        for <linux-nfs@vger.kernel.org>; Fri,  8 Jul 2022 13:38:51 -0700 (PDT)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=A507L1UQvzZsZP5l4DYXIGdD+pjIB6uV8ClEGYGkuRjvS73yBbEeYuzPNuiOrfB50qQnHHTviQ6E/qhFV4Q04uED0oQtLWmhSoltLu1GivjQDrDshuUTKS1T5WL0PwqVzxIoVOQNhFLydv20vVpC3Ut6yLzimllxfn2xcZVjPGuWniZXnfJLjsjnlem4QSL2XMrWMD9ntBCYzdWBI+2mnAORVRNBIYldrtuMkfsQWs5F/KtXmhOdqDEl+UqJ2KtjVZRzicv1x2XyhGxSBQmIIDOXWNH1x4MY5JFxaTivmsaFEFC6Tto0cEJe2KO250+8zAj0AZzfrE0G3IIOpJ00oA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ek9H2EA+E5kOhQf2Co/qmdn4Y47eSJyocQHFF0ORTQ4=;
 b=UhgiQGP3xGdYyKPniQdITK/YE/TIV0mdKCvpG/skk3VNZ8TGmnUyiIf6aRws6byyiH3RlqsBEgS61WS/7w6IFzR1DnihmXmL8KfpxH3vmdcM8r1Twa0ZEuvqGuhli0j36hmQ1oQRCwT0N16gI+YixK5fA178OASiG+hp01+5D++do0E9lzYyZYOm0m2l+qR8UbS79EGjNOwDY0DSXXnLkAMt61teoi4kQkWMKlrcF7xW6hyaXb7JFvSoYUXSqJIcA+7uny/2EDVKjX2dL26oe72rdsPsVnm2zqpjGXqwTixm7zQf/ekEmbmcYm7j4mih4wGt543/Sz/YaxFM3PZJBA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=fail (sender ip is
 144.49.247.126) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=hcl.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=hcl.com;
 dkim=pass (signature was verified) header.d=hcl.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=hcl.com] dkim=[1,1,header.d=hcl.com]
 dmarc=[1,1,header.from=hcl.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HCL.COM; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ek9H2EA+E5kOhQf2Co/qmdn4Y47eSJyocQHFF0ORTQ4=;
 b=wfai+2hZy0laPkdGymci7/jnuOtaWmBV3W9+HJldLxT7SP00X1lyr6uuC4GPj9RNEMt8Soj9wjzpaLCooXH7GXBTOVSDQ5ZjHqRrH8AFLMqlMK7VjEFqt3x/Iaw1Nb7hv7dja1v/NRKQ7EPP1YwHr0XzaQ4S1kQZqIBMaJa7sQ5UdZ2Tnbxil8ItYaTXEbI+IcoEHF7AV2PjSnbhD+8zkT2vcIwABFHqEm53NX1WpoufSLBgn7LkrHxL4hLyQHAWr3Qfr8YqT5XBLRZqMMqIQDdiaPULjT7uMf8Mshz9sOMpyr0M8hSnFTd1p3VoAbznn7OxeW0dLvp+9ieOvhJlAg==
Received: from PS2PR02CA0049.apcprd02.prod.outlook.com (2603:1096:300:5a::13)
 by TYZPR04MB4872.apcprd04.prod.outlook.com (2603:1096:400:127::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Fri, 8 Jul
 2022 20:38:49 +0000
Received: from PSAAPC01FT065.eop-APC01.prod.protection.outlook.com
 (2603:1096:300:5a:cafe::c) by PS2PR02CA0049.outlook.office365.com
 (2603:1096:300:5a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.21 via Frontend
 Transport; Fri, 8 Jul 2022 20:38:49 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 144.49.247.126)
 smtp.mailfrom=hcl.com; dkim=pass (signature was verified)
 header.d=HCL.COM;dmarc=pass action=none header.from=hcl.com;
Received-SPF: Fail (protection.outlook.com: domain of hcl.com does not
 designate 144.49.247.126 as permitted sender)
 receiver=protection.outlook.com; client-ip=144.49.247.126;
 helo=mail.ds.dlp.protect.symantec.com;
Received: from mail.ds.dlp.protect.symantec.com (144.49.247.126) by
 PSAAPC01FT065.mail.protection.outlook.com (10.13.38.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.15 via Frontend Transport; Fri, 8 Jul 2022 20:38:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J8GD73s78JyICN0RZ3U1rXa18ToYzg6lu24et+Brm87Xbx+ijbgt62a9S8av444YF4Vv+XYTLjqRatvs3d6R+5pj4Nxy1VVVpVyHa9COc3zWBmYabgpMWZNabYwDOZkAjAuwlvZ95YhQZXeuJO6yUtwg/mjbwLE6l0cP5oB2OhaPvrjPSj/QcVKIYRs8xDqD/alOByZ5vZgz0B3Jc3SjulBfE0GPoMcgzSTyZnZ4cbCyL08DwtOj1MbfF6xXguHLSxFFxdX7j/TXveylw8btc22RWUyvj9EipOxe6MtK2VrAt084KXtkQfnC/YkPxK1YA7wQxsE2w2LBXFosA9lBVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ek9H2EA+E5kOhQf2Co/qmdn4Y47eSJyocQHFF0ORTQ4=;
 b=bG3fA61fjyN91+4Bdy7NHL6WKQsRs0FyTJ9GhPQaBNkK6Er0VaeJMqJnZb7GV4pk7axUDeITb8VhlK8L8YmdUbbgjDbs77bKZYZawermfIOQq0wFyNqo/3bfU+YiAAHbi6fPl4E0/1yLG/maHcJt0GbnTQsDMxUQ+9CRAuSJrdYUt8CxoHE4Stiw4+28tLqyn3OH5VzbYaOQ4yU9B5fRd1uZ4GmewM9BtspMw1Bmx+R/CkRgk1LHifwP+Ce7hVKrgz1xbyD4OIoR5nM0iOY0+meDfPJEzlqFLZSXZpKVc/Z/sppx5/iX2tPTG/d9+GIUj45ytA+fl62791wlmBrBaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hcl.com; dmarc=pass action=none header.from=hcl.com; dkim=pass
 header.d=hcl.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HCL.COM; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ek9H2EA+E5kOhQf2Co/qmdn4Y47eSJyocQHFF0ORTQ4=;
 b=wfai+2hZy0laPkdGymci7/jnuOtaWmBV3W9+HJldLxT7SP00X1lyr6uuC4GPj9RNEMt8Soj9wjzpaLCooXH7GXBTOVSDQ5ZjHqRrH8AFLMqlMK7VjEFqt3x/Iaw1Nb7hv7dja1v/NRKQ7EPP1YwHr0XzaQ4S1kQZqIBMaJa7sQ5UdZ2Tnbxil8ItYaTXEbI+IcoEHF7AV2PjSnbhD+8zkT2vcIwABFHqEm53NX1WpoufSLBgn7LkrHxL4hLyQHAWr3Qfr8YqT5XBLRZqMMqIQDdiaPULjT7uMf8Mshz9sOMpyr0M8hSnFTd1p3VoAbznn7OxeW0dLvp+9ieOvhJlAg==
Received: from SI2PR04MB5821.apcprd04.prod.outlook.com (2603:1096:4:1e5::8) by
 SEYPR04MB6553.apcprd04.prod.outlook.com (2603:1096:101:bb::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5373.18; Fri, 8 Jul 2022 20:38:42 +0000
Received: from SI2PR04MB5821.apcprd04.prod.outlook.com
 ([fe80::a846:c040:fd9e:2ca5]) by SI2PR04MB5821.apcprd04.prod.outlook.com
 ([fe80::a846:c040:fd9e:2ca5%9]) with mapi id 15.20.5417.019; Fri, 8 Jul 2022
 20:38:41 +0000
From:   Brian Cowan <brian.cowan@hcl.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Any way to make the NFS server ALWAYS report its NFS domain name when
 returning an ACL?
Thread-Topic: Any way to make the NFS server ALWAYS report its NFS domain name
 when returning an ACL?
Thread-Index: AdiTCInhEYXITo0+QLKqItlSwqlPKA==
Date:   Fri, 8 Jul 2022 20:38:41 +0000
Message-ID: <SI2PR04MB58213B077411EC88ECD11124FE829@SI2PR04MB5821.apcprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcYnJpYW4uY293YW5cYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy1mMjRiZWI1Ny1mZWZkLTExZWMtODlkOS1mOGU0ZTNkOGYxZjdcYW1lLXRlc3RcZjI0YmViNTgtZmVmZC0xMWVjLTg5ZDktZjhlNGUzZDhmMWY3Ym9keS50eHQiIHN6PSIyNzYzIiB0PSIxMzMwMTc4NjMxOTc1Mzc1NzIiIGg9ImlQRVJxOGV4V1gzOXlWVG4zYzBPUGVNSFlGOD0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hcl.com;
X-MS-Office365-Filtering-Correlation-Id: b24628a8-4c4e-4590-7c81-08da6121dc81
x-ms-traffictypediagnostic: SEYPR04MB6553:EE_|PSAAPC01FT065:EE_|TYZPR04MB4872:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: vNtmRrZGbgxqePf9WXUNACgu60lW/614rW9E/2eMHGvXEU5B6kB+AzkdaPzzbKLE/zonv4Gmurfoif5/tDrAfeyiKW8vR0OpNSwmOKzk19jts7k35Q5M2YdESdp2FmozHmX+w6kbZsu+lJakveaH9ofMn3GfLOLSGSgdJFaGxgVPSrf0kN3UKfTQlvJFIZSCM/WEdlGwmnqQU7hwiOgMoZxyCKOKbK9SG+lBfc4zrGblgh9cFaAWfNTxMMtf3yTsApOdAF4GFQ/sIWyuorpW6rkJP3L0cX1/BA0RePz8wkcwQUvBXOjFgdAEgkApaEGJVEklQQRtlu2xJRYA4zRhoJohWqjgj4JMzWCEhRLOLa+tcPdKr1FdIp86N9kQHYpR6UU2bcENL2UBgaC21CCMeLjGWlplwBKHp1Y1Kl+srkZGe0+jxJmxdDjrrYhi8M6Snm3BKBveJPuL5gqWrISmdKM7/XTFDtitXKFyJwb/IBFpB0EPjuYKKmLfmmOFly6LNLQ98A2iO75jL1iGHKIgKgvARx1cW+krsl02NJRUf29yt0PhL/xrZSZuoIsMIuPnwrSFSG/TcFdX8o1bT0oieRy9tGnhAbUupn/9F2zmwLW2EsIH3GYdmJnnLD6FxGx2F4VS5opkr5eGzLeCOxuJx+ExlsODDKEU6syAvj6uewRCANs2rXrTSaoDfv8C4uCAIc433iLO/RJYbZv4T6V+XT4FrKxMejIeeYsy1KK5+IaMuCwZ37lmZBy33chwQCUwPu7F6Pog0vClgCT0tihUnsH1z7S7AipcN+2ta2F7m8zZ5GiCljY66b91AD3JbtzB/4/cNfFaEBn8F9RoxH9OdA==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR04MB5821.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(346002)(136003)(376002)(396003)(39860400002)(52536014)(38100700002)(33656002)(122000001)(55016003)(66556008)(66446008)(8676002)(8936002)(478600001)(316002)(71200400001)(86362001)(64756008)(66476007)(7696005)(41300700001)(2906002)(5660300002)(186003)(76116006)(9686003)(6506007)(82960400001)(6916009)(26005)(44832011)(83380400001)(38070700005)(66946007)(43043002);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR04MB6553
X-CFilter-Loop: Reflected
X-DetectorID-Processed: 7a3ff160-c3d4-11eb-a2f1-967d7d39dbda
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: PSAAPC01FT065.eop-APC01.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: d02d06f0-1aa2-461c-9547-08da6121d84b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BO6vY2mRWj9OKovsS6T5pMbZUz7zUC+Ugfb2t09UscEna6KhHAluwZrsnr2uExzoSZSYQvpaz3fCQIbwVotYwnyBoYZU60RMUxuupDYIkmawa1sJOyqj2UCVGD593lDOvJYz4fv0kdbZ+oxZLcd4R0iwxXOryp+ChsxohmEZnSseVQRu6u0OQMreKM2cT6ootPfTpZ3LpgkP0ylv4xyifyxIShWYPo7ZIKVClD0926aMmXeZr4yYWlRimgsSWXnTuks5hmAjOg/FTmXSRgHN6b8ANarTjFk/e8NJnqf3+3h00ksXeD3hE+hQmbJeulKv5b9tqpTb4xbSq4bLaXaLFLnrVigOmDJiY8pNuwy+FF3jFvsGFBRIjKO0xomi9A4wlpH3XV2z+gUOu7iOlWiBrt1HNGhPNYAG4TIFemFDKusl7ne7fsYvznZGweMyB/+nSW6NrjFjq8poo652XY8X0A9mHWNPbJUvol2sEnKJHpoZzBy8GliXTejmke07W19jM4qPvTEexDKnow63mkDx0LsO2V8fzMvTuonZkwcgWVHx2tSTEpH6+uR4AcrKppjh7BZdpf+QzBICFLt7kdiz9VMUTTj4JhCibr3uZTrSdv6EkhWC07aTN20EofGPAXu93pzTa4Y7c8eQkgKwBnQvOBxWL3cqYfxbF6Hvtoi10W6cVqVUM6gPGtg/1LhJrx/5GOUenZV38CkCn35IHh2fCqOczh0h3bJtL6lDUCwhwFqH1nVMn3Bm1dVTUnM+Rndz2H2TeuajZ2UCfp/vNaJMk7qUvrNqJecWP0ewo4NNCAwNH24KJzdGx16D7xDdgm/TO+GHVxi7Fo2uzFwRc81d2o6Jz8d8APBGVQg/dR4COblLH9OrzASwh7p7exIyJHYE
X-Forefront-Antispam-Report: CIP:144.49.247.126;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.ds.dlp.protect.symantec.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(136003)(39860400002)(376002)(36840700001)(40470700004)(46966006)(40480700001)(55016003)(26005)(9686003)(44832011)(2906002)(5660300002)(8936002)(478600001)(41300700001)(6506007)(33656002)(336012)(47076005)(83380400001)(7696005)(186003)(36906005)(316002)(6916009)(40460700003)(36860700001)(82740400003)(86362001)(81166007)(82960400001)(356005)(52536014)(70586007)(70206006)(82310400005)(8676002)(43043002)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: HCL.COM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 20:38:48.1854
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b24628a8-4c4e-4590-7c81-08da6121dc81
X-MS-Exchange-CrossTenant-Id: 189de737-c93a-4f5a-8b68-6f4ca9941912
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=189de737-c93a-4f5a-8b68-6f4ca9941912;Ip=[144.49.247.126];Helo=[mail.ds.dlp.protect.symantec.com]
X-MS-Exchange-CrossTenant-AuthSource: PSAAPC01FT065.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB4872
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi all, Long time since I wasn't a lurker here...

After some serious google-whacking, I managed to get a RHEL 8.6 NFS server =
to return NFSv4 ACL's for files where the entries were names and not number=
s... It feels a little kludgy to me to create a script to set the nfsd opti=
ons in /etc/modprobe.d... But anyways...

The issue I'm currently dealing with is that -- at least for hosts in the s=
ame "nfs domain" (same Domain in idmapd.conf, and using the same AD domain =
via sssd) -- nfs4_getfacl reports bare names in the ACL entries. For exampl=
e:
--------------------------------
[vobadm@vv-30-rh85 ~]$  nfs4_getfacl /net/bc-rh86-nfs/export/nfs/vobstore/s=
iddumptest-rep.vbs/s/sdft/3c/13/2-0f41817b67fc11ec84e2525400c90287-t7
# file: /net/bc-rh86-nfs/export/nfs/vobstore/siddumptest-rep.vbs/s/sdft/3c/=
13/2-0f41817b67fc11ec84e2525400c90287-t7
A::OWNER@:rtTcCy
A::a.human.user:rtcy
A::vobadm:rtcy
A::GROUP@:rtcy
A:g:ccusers:rtcy
A:g:asdf_0:rtcy
A::EVERYONE@:rtcy
--------------------------------

The problem is, the application that is verifying the NFS4 ACL against perm=
issions stored in a database (Yes, it's still ClearCase, and ClearCase is s=
till around) is written assuming that the above output reads like this:
--------------------------------
[vobadm@vv-30-rh85 ~]$  nfs4_getfacl /net/bc-rh86-nfs/export/nfs/vobstore/s=
iddumptest-rep.vbs/s/sdft/3c/13/2-0f41817b67fc11ec84e2525400c90287-t7
# file: /net/bc-rh86-nfs/export/nfs/vobstore/siddumptest-rep.vbs/s/sdft/3c/=
13/2-0f41817b67fc11ec84e2525400c90287-t7
A::OWNER@:rtTcCy
A::a.human.user@swtest.local:rtcy
A::vobadm@swtest.local:rtcy
A::GROUP@:rtcy
A:g:ccusers@swtest.local:rtcy
A:g:asdf_0@swtest.local:rtcy
A::EVERYONE@:rtcy
--------------------------------

Getting to this point was something of a long road involving building instr=
umented code to tell me something other than "no, I don't like the ACL..."

The file in question looks like this on the NFS server:
[testuser@bc-rh86-nfs ~]$ getfacl /export/nfs/vobstore/siddumptest-rep.vbs/=
s/sdft/3c/13/2-0f41817b67fc11ec84e2525400c90287-t7
getfacl: Removing leading '/' from absolute path names
# file: export/nfs/vobstore/siddumptest-rep.vbs/s/sdft/3c/13/2-0f41817b67fc=
11ec84e2525400c90287-t7
# owner: vobadm
# group: asdf_0
user::r--
user:a.human.user:r--
user:vobadm:r--
group::r--
group:ccusers:r--
group:asdf_0:r--
mask::r--
other::r--

Is it possible to make the NFS server host always report the NFS domain nam=
e in response to this request? Because if there is, it's either well hidden=
 or I'm having my usual issues with stuff staring me in the face...

Thanks in advance

Brian
::DISCLAIMER::
________________________________
The contents of this e-mail and any attachment(s) are confidential and inte=
nded for the named recipient(s) only. E-mail transmission is not guaranteed=
 to be secure or error-free as information could be intercepted, corrupted,=
 lost, destroyed, arrive late or incomplete, or may contain viruses in tran=
smission. The e mail and its contents (with or without referred errors) sha=
ll therefore not attach any liability on the originator or HCL or its affil=
iates. Views or opinions, if any, presented in this email are solely those =
of the author and may not necessarily reflect the views or opinions of HCL =
or its affiliates. Any form of reproduction, dissemination, copying, disclo=
sure, modification, distribution and / or publication of this message witho=
ut the prior written consent of authorized representative of HCL is strictl=
y prohibited. If you have received this email in error please delete it and=
 notify the sender immediately. Before opening any email and/or attachments=
, please check them for viruses and other defects.
________________________________
